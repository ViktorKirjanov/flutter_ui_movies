import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';

class BuyButton extends StatefulWidget {
  const BuyButton({super.key, required this.enabled});

  final bool enabled;

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> with TickerProviderStateMixin {
  late final AnimationController _diameterController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late final AnimationController _borderController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late final AnimationController _sizeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  var _isAnimationFinished = true;

  void _forwardAnimation() {
    if (_sizeController.status == AnimationStatus.dismissed) {
      _diameterController.forward().then(
            (_) => _borderController.forward().then((_) {
              _diameterController.reset();
              _borderController.reset();
            }).then(
              (_) => _sizeController
                  .forward()
                  .then((_) => _isAnimationFinished = false),
            ),
          );
    }
  }

  void _reverseAnimation() {
    setState(() => _isAnimationFinished = false);

    _sizeController.reverse().then(
          (_) => Future<void>.delayed(const Duration(milliseconds: 1500)).then(
            (_) => setState(
              () => _isAnimationFinished = true,
            ),
          ),
        );
  }

  @override
  void dispose() {
    _diameterController.dispose();
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .75 - 48;
    final fullWidth = MediaQuery.of(context).size.width - 48;
    final widthDifference = fullWidth - width;
    return BlocListener<DetailPageCubit, DetailPageState>(
      listener: (_, state) {
        if (state == DetailPageState.completed) {
          _forwardAnimation();
        } else if (state == DetailPageState.dismissed) {
          _reverseAnimation();
        }
      },
      child: Positioned(
        bottom: 10.0,
        left: .0,
        right: .0,
        child: SafeArea(
          child: GestureDetector(
            onTap: widget.enabled && _isAnimationFinished
                ? (() => context.read<DetailPageCubit>().forward())
                : null,
            child: Stack(
              children: [
                Center(
                  child: AnimatedBuilder(
                    animation: _sizeController,
                    builder: (_, child) => SizedBox(
                      width: width + _sizeController.value * widthDifference,
                      child: child,
                    ),
                    child: Container(
                      height: 55.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: widget.enabled
                            ? Colors.grey.shade800
                            : Colors.grey.shade500,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: const Center(
                        child: Text(
                          'BUY TICKET',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 55.0,
                    width: 55.0,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _diameterController,
                          _borderController,
                        ]),
                        builder: (_, child) => Container(
                          height: _diameterController.value * 55.0,
                          width: _diameterController.value * 55.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 15.0 - _borderController.value * 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
