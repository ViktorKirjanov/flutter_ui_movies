import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  const Actor({
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  List<Object?> get props => [name, image];
}
