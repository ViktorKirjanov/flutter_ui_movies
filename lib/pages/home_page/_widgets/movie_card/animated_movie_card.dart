import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_movies/blocs/detail-page-cubit/detail_page_cubit.dart';
import 'package:flutter_ui_movies/models/actor_model.dart';
import 'package:flutter_ui_movies/models/movie_model.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/_widgets/more_horiz.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/_widgets/movie_rate.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/actor_animation.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/stars/star_animation.dart';

import 'stars/filled_star.dart';
import 'stars/border_star.dart';
import 'header_transform_offset.dart';
import '_widgets/movie_chip.dart';
import '../movie_image.dart';
import '_widgets/movie_title.dart';

class AnimatedMovieCard extends StatefulWidget {
  final Movie movie;

  const AnimatedMovieCard({
    super.key,
    required this.movie,
  });

  @override
  State<AnimatedMovieCard> createState() => _AnimatedMovieCardState();
}

class _AnimatedMovieCardState extends State<AnimatedMovieCard>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _widthAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 250));

  late final AnimationController _imageAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 250));

  late final AnimationController _titleAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

  late final AnimationController _directorAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

  late final AnimationController _actorsTitleAnimatedController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

  late final AnimationController _descriptionController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  bool isScrollable = false;
  bool ignorePointer = true;
  bool isComplete = false;

  @override
  void dispose() {
    _widthAnimationController.dispose();
    _imageAnimationController.dispose();
    _titleAnimationController.dispose();
    _directorAnimationController.dispose();
    _actorsTitleAnimatedController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _forward() {
    _scrollController.jumpTo(0);

    setState(() {
      isScrollable = true;
      ignorePointer = false;
    });

    Future.delayed(const Duration(milliseconds: 300))
        .then((_) => _widthAnimationController.forward());

    Future.delayed(const Duration(milliseconds: 300))
        .then((_) => _imageAnimationController.forward());

    Future.delayed(const Duration(milliseconds: 425))
        .then((_) => _titleAnimationController.forward());

    Future.delayed(const Duration(milliseconds: 1000))
        .then((_) => _directorAnimationController.forward());

    Future.delayed(const Duration(milliseconds: 1000))
        .then((_) => _actorsTitleAnimatedController.forward());

    Future.delayed(const Duration(milliseconds: 1500))
        .then((_) => _descriptionController.forward())
        .then((_) {
      setState(() => isComplete = true);
    });
  }

  void _reverse() {
    _descriptionController.reverse();

    setState(() {
      isScrollable = false;
      ignorePointer = true;
    });

    Future.delayed(const Duration(milliseconds: 250)).then((_) {
      _actorsTitleAnimatedController.reverse();
      _directorAnimationController.reverse();
    });

    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      _titleAnimationController.reverse();
    });

    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      _imageAnimationController.reverse();
      _widthAnimationController.reverse();
    });

    setState(() => isComplete = false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final startWidth = MediaQuery.of(context).size.width * .75 - 16.0;

    return BlocListener<DetailPageCubit, DetailPageState>(
      listener: (_, state) {
        if (state == DetailPageState.completed) {
          _forward();
        } else if (state == DetailPageState.dismissed) {
          _reverse();
        }
      },
      child: IgnorePointer(
        ignoring: ignorePointer,
        child: Padding(
          padding: EdgeInsets.only(top: size.height * .25),
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _widthAnimationController,
                _imageAnimationController,
                _titleAnimationController,
                _directorAnimationController,
                _actorsTitleAnimatedController,
              ]),
              builder: (_, child) {
                return Container(
                  alignment: Alignment.topCenter,
                  height: size.height * .75,
                  width: startWidth +
                      _widthAnimationController.value *
                          (size.width - startWidth),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.0),
                    ),
                  ),
                  child: _buildContent(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        Column(
          children: [
            _buildImage(),
            Column(
              children: [
                const SizedBox(height: 12.0),
                _buildTitle(),
                const SizedBox(height: 8.0),
                _buildGenres(),
                const SizedBox(height: 12.0),
                _buildStars(),
                const SizedBox(height: 12.0),
                _buildMoreHoriz(),
              ],
            ),
          ],
        ),
        _buildMovieDescription(),
      ],
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Transform.scale(
        scale: 1 - _imageAnimationController.value,
        child: SizedBox(
          child: MovieImage(image: widget.movie.image),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return HeaderTransformOffset(
      animationController: _titleAnimationController,
      child: MovieTitle(title: widget.movie.title),
    );
  }

  Widget _buildGenres() {
    return HeaderTransformOffset(
      animationController: _titleAnimationController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.movie.genres
            .map((genre) => MovieChip(genre: genre))
            .toList(),
      ),
    );
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StarAnimation(
          initDelayMilliseconds: 0,
          child: Row(
            children: [
              MovieRate(rate: widget.movie.rate),
              const SizedBox(width: 8.0),
              const FilledStar(),
            ],
          ),
        ),
        const StarAnimation(
          initDelayMilliseconds: 100,
          child: FilledStar(),
        ),
        const StarAnimation(
          initDelayMilliseconds: 200,
          child: FilledStar(),
        ),
        const StarAnimation(
          initDelayMilliseconds: 300,
          child: FilledStar(),
        ),
        const StarAnimation(
          initDelayMilliseconds: 400,
          child: BorderStar(),
        ),
      ],
    );
  }

  Widget _buildMovieDescription() {
    return IgnorePointer(
      ignoring: ignorePointer,
      child: Padding(
        padding: const EdgeInsets.only(top: 100 + 50),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .75 - 250,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _directorAnimationController,
                  builder: ((_, child) {
                    return Transform.translate(
                      offset: Offset(
                        .0,
                        200.0 * (1 - _directorAnimationController.value),
                      ),
                      child: Opacity(
                        opacity: _directorAnimationController.value,
                        child: child,
                      ),
                    );
                  }),
                  child: Center(
                    child: Text('Director / ${widget.movie.director}'),
                  ),
                ),
                const SizedBox(height: 28.0),
                AnimatedBuilder(
                  animation: _actorsTitleAnimatedController,
                  builder: ((_, child) {
                    return Transform.translate(
                      offset: Offset(
                        .0,
                        200.0 * (1 - _actorsTitleAnimatedController.value),
                      ),
                      child: Opacity(
                        opacity: _actorsTitleAnimatedController.value,
                        child: child,
                      ),
                    );
                  }),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Actors',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Stack(
                  children: [
                    SizedBox(
                      height: 135.0 + 200.0,
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 24.0),
                        itemCount: widget.movie.actors.length,
                        itemBuilder: ((_, index) {
                          return ActorAnimation(
                            key: Key(index.toString()),
                            initDelayMilliseconds: 100 * index,
                            child: _buildActor(
                              index,
                              widget.movie.actors[index],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 175.0),
                      child: AnimatedBuilder(
                        animation: _descriptionController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(
                              0.0,
                              .0 + 200 * (1 - _descriptionController.value),
                            ),
                            child: Opacity(
                              opacity: _descriptionController.value,
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 24.0),
                                child: Text(
                                  'Introduction',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  widget.movie.description +
                                      widget.movie.description,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActor(int index, Actor actor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 24.0),
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            image: DecorationImage(
              image: AssetImage(actor.image),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(actor.name),
      ],
    );
  }

  Widget _buildMoreHoriz() {
    return AnimatedBuilder(
      animation: _imageAnimationController,
      builder: ((_, child) {
        return Opacity(
          opacity: 1 - _imageAnimationController.value,
          child: child,
        );
      }),
      child: const MoreHoriz(),
    );
  }
}
