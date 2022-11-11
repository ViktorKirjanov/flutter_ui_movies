import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  BackgroundClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(
      Rect.fromLTRB(
        size.width - (size.width * progress),
        0,
        size.width,
        size.height,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
