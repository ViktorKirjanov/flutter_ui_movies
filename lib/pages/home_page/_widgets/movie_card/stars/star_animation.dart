import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';

class StarAnimation extends StatefulWidget {
  final int initDelayMilliseconds;
  final Widget child;

  const StarAnimation({
    super.key,
    required this.initDelayMilliseconds,
    required this.child,
  });

  @override
  State<StarAnimation> createState() => _StarAnimationState();
}

class _StarAnimationState extends State<StarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    offsetAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  void _forward() {
    Future.delayed(Duration(milliseconds: 250 + widget.initDelayMilliseconds))
        .then((_) => _animationController.forward());
  }

  void _reverse() {
    Future.delayed(Duration(milliseconds: 250 + widget.initDelayMilliseconds))
        .then((_) => _animationController.reverse());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final yOffset = (MediaQuery.of(context).size.height * .4);

    return BlocListener<DetailPageCubit, DetailPageState>(
      listener: (_, state) {
        if (state == DetailPageState.completed) {
          _forward();
        } else if (state == DetailPageState.dismissed) {
          _reverse();
        }
      },
      child: Transform.translate(
        offset: Offset(.0, .0 - yOffset * offsetAnimation.value),
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}
