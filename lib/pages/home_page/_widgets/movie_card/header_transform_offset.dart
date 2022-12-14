import 'package:flutter/material.dart';

class HeaderTransformOffset extends StatelessWidget {
  const HeaderTransformOffset({
    super.key,
    required this.child,
    required this.animationController,
  });

  final Widget child;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final titleYOffset = MediaQuery.of(context).size.height * .4;

    return Transform.translate(
      offset: Offset(
        .0,
        animationController.value != .0
            ? -animationController.value * titleYOffset
            : .0,
      ),
      child: child,
    );
  }
}
