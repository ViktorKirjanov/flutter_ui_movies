import 'package:flutter/material.dart';

import 'background_clipper.dart';

class BackgroundSlider extends StatelessWidget {
  final int index;
  final String image;
  final double pageValue;

  const BackgroundSlider({
    Key? key,
    required this.index,
    required this.image,
    required this.pageValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var progress = getProgress();
    return ClipPath(
      clipper: BackgroundClipper(progress: progress),
      child: Image.asset(
        image,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  double getProgress() {
    if (index == pageValue.floor()) {
      return 1.0 - (pageValue - index);
    } else if (index < pageValue.floor()) {
      return 0.0;
    } else {
      return 1.0;
    }
  }
}
