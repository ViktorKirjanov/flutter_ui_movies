import 'package:flutter/material.dart';
import 'package:flutter_ui_movies/models/movie_model.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/_widgets/more_horiz.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/_widgets/movie_chip.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/_widgets/movie_rate.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/_widgets/movie_title.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/stars/border_star.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_card/stars/filled_star.dart';
import 'package:flutter_ui_movies/pages/home_page/_widgets/movie_image.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.offset,
    required this.opacity,
  });

  final Movie movie;
  final Offset offset;
  final double opacity;

  @override
  Widget build(BuildContext context) => Center(
        child: Transform.translate(
          offset: offset,
          child: Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: MovieImage(image: movie.image),
                ),
                Opacity(
                  opacity: opacity,
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildContent() => Column(
        children: [
          const SizedBox(height: 12.0),
          MovieTitle(title: movie.title),
          const SizedBox(height: 8.0),
          _buildGenres(),
          const SizedBox(height: 12.0),
          _buildStars(),
          const SizedBox(height: 12.0),
          const MoreHoriz(),
        ],
      );

  Widget _buildGenres() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: movie.genres.map((genre) => MovieChip(genre: genre)).toList(),
      );

  Widget _buildStars() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MovieRate(rate: movie.rate),
          const SizedBox(width: 8.0),
          const FilledStar(),
          const FilledStar(),
          const FilledStar(),
          const FilledStar(),
          const BorderStar(),
        ],
      );
}
