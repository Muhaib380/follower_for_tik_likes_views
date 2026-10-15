import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  /// assets/images/google.png lagane ke baad asli Google logo dikhega.
  /// File na ho to fallback "G" dikhta hai.
  factory SocialButton.google({VoidCallback? onPressed}) => SocialButton(
    text: 'Continue with Google',
    icon: Image.asset(
      'assets/images/google.png',
      height: 24,
      width: 24,
      errorBuilder: (_, __, ___) => const Text(
        'G',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF4285F4),
        ),
      ),
    ),
    onPressed: onPressed,
  );

  factory SocialButton.apple({VoidCallback? onPressed}) => SocialButton(
    text: 'Continue with Apple',
    icon: const Icon(Icons.apple, size: 26),
    onPressed: onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          side: BorderSide(color: Theme.of(context).dividerColor),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(text),
          ],
        ),
      ),
    );
  }
}