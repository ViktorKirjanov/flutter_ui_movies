import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  final String name;
  final String image;

  const Actor({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];
}
