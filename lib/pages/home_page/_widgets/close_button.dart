import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';

class CloseDetailsButton extends StatefulWidget {
  const CloseDetailsButton({super.key});

  @override
  State<CloseDetailsButton> createState() => _CloseDetailsButtonState();
}

class _CloseDetailsButtonState extends State<CloseDetailsButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 250));

  void _forwardAnimation() {
    Future.delayed(const Duration(milliseconds: 1750))
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
    return Positioned(
      left: 10.0,
      top: .0,
      child: SafeArea(
        child: BlocBuilder<DetailPageCubit, DetailPageState>(
          builder: (_, state) {
            if (state == DetailPageState.completed) {
              _forwardAnimation();
            } else if (state == DetailPageState.dismissed) {
              _reverseAnimation();
            }
            return AnimatedBuilder(
              animation: _animationController,
              builder: (_, child) {
                return Transform.translate(
                  offset: Offset(
                    .0,
                    -100.0 * (1.0 - _animationController.value),
                  ),
                  child: child,
                );
              },
              child: CupertinoButton(
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (state == DetailPageState.completed) {
                    context.read<DetailPageCubit>().reverse();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
