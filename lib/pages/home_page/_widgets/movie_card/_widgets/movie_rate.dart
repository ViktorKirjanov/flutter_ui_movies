import 'package:flutter/material.dart';

class MovieRate extends StatelessWidget {
  const MovieRate({
    super.key,
    required this.rate,
  });

  final double rate;

  @override
  Widget build(BuildContext context) => Text(
        rate.toStringAsFixed(1),
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      );
}
