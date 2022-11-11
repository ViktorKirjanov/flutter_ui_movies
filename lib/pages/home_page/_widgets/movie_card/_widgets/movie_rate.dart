import 'package:flutter/material.dart';

class MovieRate extends StatelessWidget {
  final double rate;

  const MovieRate({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      rate.toStringAsFixed(1),
      style: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
