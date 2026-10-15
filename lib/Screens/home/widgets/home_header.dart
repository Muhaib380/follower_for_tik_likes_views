import 'package:flutter/material.dart';

/// "Hello, Muhib 👋 / Let's grow together!" aur bell icon.
class HomeHeader extends StatelessWidget {
  final String name;
  final bool hasNotification;
  final VoidCallback? onBellTap;

  const HomeHeader({
    super.key,
    required this.name,
    this.hasNotification = true,
    this.onBellTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $name \u{1F44B}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Let's grow together!",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onBellTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded,
                    color: Colors.white, size: 30),
                if (hasNotification)
                  Positioned(
                    right: 2,
                    top: 1,
                    child: Container(
                      height: 9,
                      width: 9,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4D4D),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF3A1C9E), width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}