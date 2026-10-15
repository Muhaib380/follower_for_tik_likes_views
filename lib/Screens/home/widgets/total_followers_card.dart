import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';


/// Glass jaisa "Total Followers" card: count, growth % aur right par icon box.
class TotalFollowersCard extends StatelessWidget {
  final String count;   // e.g. '12.4K'
  final String growth;  // e.g. '+12%'

  const TotalFollowersCard({
    super.key,
    required this.count,
    required this.growth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7B4DFF).withOpacity(0.60),
            const Color(0xFF5B2EE0).withOpacity(0.45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Followers',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.92),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.arrow_upward_rounded,
                        color: Color(0xFF4ADE80), size: 16),
                    const SizedBox(width: 2),
                    Text(
                      growth,
                      style: const TextStyle(
                        color: Color(0xFF4ADE80),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 78,
            width: 78,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.people_alt_rounded,
                color: AppColors.primary, size: 38),
          ),
        ],
      ),
    );
  }
}