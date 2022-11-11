import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';

class ActorAnimation extends StatefulWidget {
  final int initDelayMilliseconds;
  final Widget child;

  const ActorAnimation({
    super.key,
    required this.initDelayMilliseconds,
    required this.child,
  });

  @override
  State<ActorAnimation> createState() => _ActorAnimationState();
}

class _ActorAnimationState extends State<ActorAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  void _forwardAnimation() {
    Future.delayed(Duration(milliseconds: 1250 + widget.initDelayMilliseconds))
        .then((_) => _animationController.forward());
  }

  void _reverseAnimation() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailPageCubit, DetailPageState>(
      listener: (_, state) {
        if (state == DetailPageState.completed) {
          _forwardAnimation();
        } else if (state == DetailPageState.dismissed) {
          _reverseAnimation();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, child) {
          return Transform.translate(
            offset: Offset(.0, 135.0 * (1 - _animationController.value)),
            child: Opacity(
              opacity: _animationController.value,
              child: child,
            ),
          );
        },
        child: Center(child: widget.child),
      ),
    );
  }
}
