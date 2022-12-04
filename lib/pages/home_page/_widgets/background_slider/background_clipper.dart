import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  BackgroundClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    final path = Path().addRect(
      Rect.fromLTRB(
        size.width - (size.width * progress),
        0,
        size.width,
        size.height,
      ),
    );

    return path as Path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
