import 'package:flutter/material.dart';

import 'package:flutter_ui_movies/pages/home_page/_widgets/background_slider/background_clipper.dart';

class BackgroundSlider extends StatelessWidget {
  const BackgroundSlider({
    Key? key,
    required this.index,
    required this.image,
    required this.pageValue,
  }) : super(key: key);

  final int index;
  final String image;
  final double pageValue;

  @override
  Widget build(BuildContext context) {
    final progress = getProgress();
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
