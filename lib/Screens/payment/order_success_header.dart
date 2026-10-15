import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Upar ka hissa: confetti, check mark wala gol icon, "Order Placed!" aur text.
class OrderSuccessHeader extends StatelessWidget {
  const OrderSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ---------- Confetti + check icon ----------
        SizedBox(
          height: 230,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _ConfettiPainter()),
              ),
              // Check wala gol icon (glow ke saath)
              Container(
                height: 104,
                width: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFB45CF0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.35), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.55),
                      blurRadius: 36,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child:
                const Icon(Icons.check_rounded, color: Colors.white, size: 58),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),

        // ---------- Title ----------
        const Text(
          'Order Placed!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Your order has been confirmed.\nWe\'ll start working on it soon.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.88),
            fontSize: 14,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _Piece {
  final double x; // 0..1 (width ka hissa)
  final double y; // 0..1 (height ka hissa)
  final double angle;
  final Color color;
  final bool dot;
  const _Piece(this.x, this.y, this.angle, this.color, {this.dot = false});
}

class _ConfettiPainter extends CustomPainter {
  static const _pink = Color(0xFFFF5CA8);
  static const _purple = Color(0xFF7B4DFF);
  static const _blue = Color(0xFF4D8DFF);
  static const _lilac = Color(0xFFD08CF5);
  static const _dim = Color(0xFF4A3A9C);

  static const _pieces = [
    _Piece(0.08, 0.30, 0.8, _blue),
    _Piece(0.18, 0.12, -0.6, _pink),
    _Piece(0.27, 0.34, 0.4, _dim),
    _Piece(0.30, 0.08, 0.7, _purple),
    _Piece(0.16, 0.58, -0.9, _dim),
    _Piece(0.36, 0.20, 0.0, _lilac, dot: true),
    _Piece(0.05, 0.10, 0.0, _dim, dot: true),
    _Piece(0.22, 0.78, 0.5, _purple),
    _Piece(0.70, 0.10, -0.5, _purple),
    _Piece(0.82, 0.16, 0.9, _pink),
    _Piece(0.92, 0.30, -0.8, _lilac),
    _Piece(0.76, 0.36, 0.3, _dim),
    _Piece(0.64, 0.06, 0.0, _lilac, dot: true),
    _Piece(0.88, 0.50, 0.6, _dim),
    _Piece(0.80, 0.70, -0.4, _purple),
    _Piece(0.60, 0.82, 0.8, _dim),
    _Piece(0.94, 0.12, 0.0, _dim, dot: true),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _pieces) {
      final paint = Paint()..color = p.color;
      canvas.save();
      canvas.translate(size.width * p.x, size.height * p.y);
      canvas.rotate(p.angle * math.pi / 2);
      if (p.dot) {
        canvas.drawCircle(Offset.zero, 3, paint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(-3, -9, 6, 18),
            const Radius.circular(2),
          ),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}