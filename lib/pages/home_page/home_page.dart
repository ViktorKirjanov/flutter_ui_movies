import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';
import 'package:flutter_ui_movies/data/movies.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/back_posters/back_posters.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/background_gradient.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/background_slider/background_slider.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/buy_button.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/close_button.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/animated_movie_card.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: .75);
  final movies = Movies().data;

  late final AnimationController _pageAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late final AnimationController _backCardAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  double _currentPage = 0.0;
  int _currentPageIndex = 0;
  bool _showCenter = true;
  bool _isButtonEnabled = true;

  void _listener() {
    _currentPage = _pageController.page!;

    _currentPageIndex = _currentPage.floor();

    if (_currentPage == 0.0 || _currentPage % 1 == 0) {
      _showCenter = true;
    } else {
      _showCenter = false;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_listener);
  }

  void _forwardAnimation() {
    Future<void>.delayed(const Duration(milliseconds: 100)).then(
      (_) => _pageAnimationController
          .forward()
          .then((_) => _backCardAnimationController.forward()),
    );
  }

  void _reverseAnimation() {
    _backCardAnimationController.reverse().then(
          (_) => Future<void>.delayed(const Duration(milliseconds: 100))
              .then((_) => _pageAnimationController.reverse()),
        );
  }

  bool _onNotification(ScrollNotification scrollState) {
    final width = MediaQuery.of(context).size.width;
    final extentInside = scrollState.metrics.extentInside;

    _isButtonEnabled = _currentPage % 1 == 0 && width == extentInside;

    if (scrollState is UserScrollNotification ||
        scrollState is ScrollEndNotification) {
      setState(() => _showCenter = true);
    } else {
      setState(() => _showCenter = false);
    }
    return false;
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    _backCardAnimationController.dispose();
    _pageController
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade500,
        body: Stack(
          children: [
            _buildBackground(),
            _buildBacgroundFade(),
            const BackgroundGradient(),
            BackPosters(
              movies: movies,
              currentPageIndex: _currentPageIndex,
            ),
            _buildPageView(),
            _buildCenterMovieCard(),
            const CloseDetailsButton(),
            BuyButton(enabled: _isButtonEnabled),
          ],
        ),
      );

  Widget _buildBackground() {
    var i = 1;
    return Stack(
      children: movies.map((_) {
        final child = BackgroundSlider(
          pageValue: _currentPage,
          image: movies[movies.length - i].image,
          index: movies.length - i,
        );
        i++;
        return child;
      }).toList(),
    );
  }

  Widget _buildBacgroundFade() => AnimatedBuilder(
        animation: _pageAnimationController,
        builder: (context, child) => Opacity(
          opacity: _pageAnimationController.value,
          child: child,
        ),
        child: Container(color: Colors.black),
      );

  Widget _buildPageView() {
    final size = MediaQuery.of(context).size;
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
          builder: (_, state) => AnimatedBuilder(
            animation: Listenable.merge([
              _pageAnimationController,
              _backCardAnimationController,
            ]),
            builder: (_, child) => Padding(
              padding: EdgeInsets.only(top: size.height * .25),
              child: SizedBox(
                height: size.height * .75,
                child: NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: PageView.builder(
                    physics: state == DetailPageState.dismissed
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    controller: _pageController,
                    itemCount: movies.length,
                    itemBuilder: (_, index) {
                      final currentPageIndex = _currentPage.floor();
                      final cardWidth = size.width * .75;
                      final imageWidth = cardWidth - 30.0 - 30.0 - 8.0 - 8.0;
                      final imageOwerflowWidth =
                          size.width * .25 / 2 - 8.0 - 30.0;
                      final imageOffsetX = imageWidth - imageOwerflowWidth;

                      var offsetX = .0;
                      if (index == currentPageIndex - 1) {
                        offsetX = .0 +
                            imageOffsetX * _backCardAnimationController.value;
                      } else if (index == currentPageIndex + 1) {
                        offsetX = .0 -
                            imageOffsetX * _backCardAnimationController.value;
                      }

                      final offsetY = (index - _currentPage).abs() * 40.0;
                      final opacity =
                          1 - (index - _currentPage).abs().clamp(0.0, 0.5);

                      if (_showCenter && index == currentPageIndex) {
                        return const SizedBox();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MovieCard(
                            movie: movies[index],
                            offset: Offset(offsetX, offsetY),
                            opacity:
                                opacity - .5 * _pageAnimationController.value,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCenterMovieCard() => _showCenter
      ? AnimatedMovieCard(
          movie: movies[_currentPageIndex],
        )
      : const SizedBox();
}
