import 'package:flutter/material.dart';

class FilledStar extends StatelessWidget {
  const FilledStar({super.key});

  @override
  Widget build(BuildContext context) => Icon(
        Icons.star,
        color: Colors.orange.shade700,
        size: 18.0,
      );
}
