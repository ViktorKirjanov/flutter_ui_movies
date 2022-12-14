import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  const MovieImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .75 - 30.0 - 30.0 - 16.0,
          height: MediaQuery.of(context).size.height * .4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(24.0),
            ),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      );
}
