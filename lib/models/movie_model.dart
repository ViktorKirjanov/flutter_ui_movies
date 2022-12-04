import 'package:equatable/equatable.dart';
import 'package:flutter_ui_movies/models/actor_model.dart';

class Movie extends Equatable {
  const Movie({
    required this.title,
    required this.image,
    required this.genres,
    required this.rate,
    required this.director,
    required this.description,
    required this.actors,
  });

  final String title;
  final String image;
  final List<String> genres;
  final double rate;
  final String director;
  final String description;
  final List<Actor> actors;

  @override
  List<Object?> get props => [
        title,
        image,
        genres,
        rate,
        director,
        description,
        actors,
      ];
}
