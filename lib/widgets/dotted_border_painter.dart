import 'dart:ui';
import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final double borderRadius;
  final double strokeWidth;
  final Color borderColor;
  final double dashWidth;
  final double dashGap;

  DottedBorderPainter(
    this.borderRadius, {
    this.strokeWidth = 1, // Thin border width
    this.borderColor = Colors.grey,
    this.dashWidth = 5, // Dash size
    this.dashGap = 3, // Gap size
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = borderColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2, // Shift inward slightly to show edges
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(roundedRect);
    _drawDottedPath(canvas, path, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0;
      while (distance < pathMetric.length) {
        final double nextDistance = distance + dashWidth;
        final Path extractPath = pathMetric.extractPath(distance, nextDistance);
        canvas.drawPath(extractPath, paint);
        distance = nextDistance + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double strokeWidth;
  final Color borderColor;
  final double dashWidth;
  final double dashGap;
  final EdgeInsets padding;

  const DottedBorderContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.strokeWidth = 1,
    this.borderColor = Colors.grey,
    this.dashWidth = 5,
    this.dashGap = 3,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
        borderRadius,
        strokeWidth: strokeWidth,
        borderColor: borderColor,
        dashWidth: dashWidth,
        dashGap: dashGap,
      ),
      child: Container(padding: padding, child: child),
    );
  }
}
