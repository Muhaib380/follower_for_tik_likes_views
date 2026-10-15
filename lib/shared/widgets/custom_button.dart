import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum ButtonType { gradient, outlined }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon; // e.g. Icons.arrow_forward (Next / Get Started)
  final bool isLoading;
  final ButtonType type;
  final double height;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.type = ButtonType.gradient,
    this.height = 56,
    this.width,
  });

  static const _gradient = LinearGradient(
    colors: [Color(0xFF6C3CE9), Color(0xFF9B5CF6)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final isGradient = type == ButtonType.gradient;
    final fg =
    isGradient ? Colors.white : Theme.of(context).colorScheme.onSurface;

    return Opacity(
      opacity: onPressed == null ? 0.5 : 1,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: isGradient ? _gradient : null,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: isGradient
              ? null
              : Border.all(color: Theme.of(context).dividerColor),
          boxShadow: isGradient
              ? [
            BoxShadow(
              color: const Color(0xFF6C3CE9).withOpacity(0.25),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppTheme.radius),
            onTap: enabled ? onPressed : null,
            child: Center(
              child: isLoading
                  ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2.5, color: fg),
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: fg,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, color: fg, size: 20),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}