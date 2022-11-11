import 'package:flutter/material.dart';

class BorderStar extends StatelessWidget {
  const BorderStar({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_border,
      color: Colors.grey.shade400,
      size: 18.0,
    );
  }
}
