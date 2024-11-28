import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Path> {
  final double radius = 150;
  final Offset circleCenter;

  CircleClipper(Size size) : circleCenter = Offset(size.width / 2, size.height / 2 - 50);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addOval(Rect.fromCircle(
        center: circleCenter, radius: radius))
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
