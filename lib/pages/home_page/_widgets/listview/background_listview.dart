import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';
import 'package:flutter_ui_movies/models/movie_model.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/movie_card.dart';

class BackgroundListView extends StatefulWidget {
  final PageController pageController;
  final AnimationController pageAnimationController;
  final List<Movie> movies;
  final double currentPage;

  const BackgroundListView({
    super.key,
    required this.pageController,
    required this.pageAnimationController,
    required this.movies,
    required this.currentPage,
  });

  @override
  State<BackgroundListView> createState() => _BackgroundListViewState();
}

class _BackgroundListViewState extends State<BackgroundListView>
    with SingleTickerProviderStateMixin {
  void _forwardAnimation() {
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => widget.pageAnimationController.forward());
  }

  void _reverseAnimation() {
    widget.pageAnimationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        BlocConsumer<DetailPageCubit, DetailPageState>(
          listener: (_, state) {
            if (state == DetailPageState.completed) {
              _forwardAnimation();
            } else if (state == DetailPageState.dismissed) {
              _reverseAnimation();
            }
          },
          builder: (_, state) {
            return AnimatedBuilder(
              animation: widget.pageAnimationController,
              builder: (_, child) {
                return Padding(
                  padding: EdgeInsets.only(top: size.height * .25),
                  child: SizedBox(
                    height: size.height * .75,
                    child: PageView.builder(
                      physics: state == DetailPageState.dismissed
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      controller: widget.pageController,
                      itemCount: widget.movies.length,
                      itemBuilder: ((_, index) {
                        final offsetY = (index - widget.currentPage).abs() *
                            40 *
                            (1 - widget.pageAnimationController.value);
                        final opacity = 1 -
                            (index - widget.currentPage).abs().clamp(0.0, 0.5);

                        var isOnPageNotTurning = widget.currentPage % 1 == 0;
                        var currentPageIndex = widget.currentPage.floor();

                        if (isOnPageNotTurning && index == currentPageIndex) {
                          return const SizedBox();
                        } else {
                          return MovieCard(
                            movie: widget.movies[index],
                            offset: Offset(.0, offsetY),
                            opacity: opacity -
                                .5 * widget.pageAnimationController.value,
                          );
                        }
                      }),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
