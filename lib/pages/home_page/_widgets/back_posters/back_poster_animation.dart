import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';

class BackPoster extends StatefulWidget {
  final int initDelayMilliseconds;
  final Widget image;

  const BackPoster({
    super.key,
    required this.initDelayMilliseconds,
    required this.image,
  });

  @override
  State<BackPoster> createState() => _BackPosterState();
}

class _BackPosterState extends State<BackPoster>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() => setState(() {}));
    offsetAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailPageCubit, DetailPageState>(
      listener: (context, state) {
        if (state == DetailPageState.completed) {
          Future.delayed(
                  Duration(milliseconds: 500 + widget.initDelayMilliseconds))
              .then((value) => _animationController.forward());
        } else if (state == DetailPageState.dismissed) {
          Future.delayed(Duration(milliseconds: widget.initDelayMilliseconds))
              .then((value) {
            _animationController.reverse();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              .0,
              .0 -
                  MediaQuery.of(context).size.height *
                      .15 *
                      offsetAnimation.value,
            ),
            child: Opacity(
              opacity: _animationController.value > .25 ? 1.0 : .0,
              child: child,
            ),
          );
        },
        child: Center(child: widget.image),
      ),
    );
  }
}
