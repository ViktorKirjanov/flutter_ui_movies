import 'package:flutter/material.dart';
import 'package:flutter_ui_movies/models/movie_model.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_image.dart';

import 'back_poster_animation.dart';

class BackPosters extends StatelessWidget {
  final List<Movie> movies;
  final int currentPageIndex;

  const BackPosters({
    super.key,
    required this.movies,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (currentPageIndex > 0)
          Positioned(
            top: MediaQuery.of(context).size.height * .31,
            left: .0,
            child: BackPoster(
              initDelayMilliseconds: 125,
              image: MovieImage(
                image: movies[currentPageIndex - 1].image,
              ),
            ),
          ),
        if (currentPageIndex < movies.length - 1)
          Positioned(
            top: MediaQuery.of(context).size.height * .31,
            right: .0,
            child: BackPoster(
              initDelayMilliseconds: 150,
              image: MovieImage(
                image: movies[currentPageIndex + 1].image,
              ),
            ),
          ),
        Positioned(
          top: MediaQuery.of(context).size.height * .25,
          left: .0,
          right: .0,
          child: BackPoster(
            initDelayMilliseconds: 75,
            image: MovieImage(
              image: movies[currentPageIndex].image,
            ),
          ),
        ),
        Container(color: Colors.black.withOpacity(.25)),
      ],
    );
  }
}
