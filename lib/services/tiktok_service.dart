import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

class TikTokProfileData {
  final String username;
  final String? nickname;
  final String? avatarUrl;
  final String followers;
  final String following;
  final String likes;

  const TikTokProfileData({
    required this.username,
    this.nickname,
    this.avatarUrl,
    required this.followers,
    required this.following,
    required this.likes,
  });

  static String formatCount(num count) {
    if (count >= 1000000) {
      final m = count / 1000000;
      return m == m.toInt() ? '${m.toInt()}M' : '${m.toStringAsFixed(1)}M';
    }
    if (count >= 1000) {
      final k = count / 1000;
      return k == k.toInt() ? '${k.toInt()}K' : '${k.toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

/// Fetches real public TikTok profile data (DP, followers, following, likes)
/// by parsing TikTok's official embed page SSR JSON — no API key required,
/// no Cloudflare block, fully legal public data.
class TikTokService {
  TikTokService._();

  static Future<TikTokProfileData?> fetchProfile(String username) async {
    final clean = username.trim().replaceAll('@', '');
    if (clean.isEmpty) return null;

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 12);

      // TikTok's official embed page — SSR renders all profile data in JSON
      // inside <script id="__FRONTITY_CONNECT_STATE__"> tag
      final uri = Uri.parse('https://www.tiktok.com/embed/@$clean');
      final request = await client.getUrl(uri);
      request.headers
        ..set('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
            'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')
        ..set('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9')
        ..set('Accept-Language', 'en-US,en;q=0.9');

      final response = await request.close();
      if (response.statusCode != 200) return null;

      final body = await response.transform(utf8.decoder).join();

      // Extract the SSR JSON blob from __FRONTITY_CONNECT_STATE__ script tag
      final scriptStart = body.indexOf('"__FRONTITY_CONNECT_STATE__"');
      if (scriptStart == -1) return null;

      // Find the JSON content inside the script tag
      final jsonStart = body.indexOf('{', scriptStart);
      final jsonEnd = body.lastIndexOf('</script>',
          body.indexOf('<script', scriptStart + 1));
      if (jsonStart == -1 || jsonEnd == -1 || jsonStart >= jsonEnd) return null;

      // The script tag ends just before </script>
      final rawJson = body.substring(jsonStart, jsonEnd).trim();

      final Map<String, dynamic> jsonData;
      try {
        jsonData = jsonDecode(rawJson) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }

      // Navigate: source -> data -> /embed/@username -> userInfo
      final source = jsonData['source'] as Map<String, dynamic>?;
      final data = source?['data'] as Map<String, dynamic>?;
      if (data == null) return null;

      // The key is the embed URL path
      final embedKey = '/embed/@$clean';
      final routeData = data[embedKey] as Map<String, dynamic>?;
      if (routeData == null) return null;

      final userInfo = routeData['userInfo'] as Map<String, dynamic>?;
      if (userInfo == null) return null;

      final avatarUrl = userInfo['avatarThumbUrl']?.toString();
      final nickname = userInfo['nickname']?.toString();
      final followerNum = (userInfo['followerCount'] as num?) ?? 0;
      final followingNum = (userInfo['followingCount'] as num?) ?? 0;
      final heartNum = (userInfo['heartCount'] as num?) ?? 0;

      return TikTokProfileData(
        username: clean,
        nickname: nickname,
        avatarUrl: avatarUrl,
        followers: TikTokProfileData.formatCount(followerNum),
        following: TikTokProfileData.formatCount(followingNum),
        likes: TikTokProfileData.formatCount(heartNum),
      );
    } catch (e) {
      debugPrint('TikTok fetchProfile error: $e');
    }
    return null;
  }
}
