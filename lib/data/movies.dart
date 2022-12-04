import 'package:flutter_ui_movies/models/actor_model.dart';
import 'package:flutter_ui_movies/models/movie_model.dart';

class Movies {
  List<Movie> data = const [
    Movie(
      title: 'The Peripheral',
      image: 'assets/movies/the_peripheral.jpg',
      genres: ['Drama', 'Mystery', 'Sci-Fi'],
      rate: 8.4,
      director: 'Jonathan Nolan',
      description:
          "Stuck in a small Appalachian town, a young woman's only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test...but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game...but it also puts her and her family in real danger.",
      actors: [
        Actor(
          name: 'Chloë Moretz',
          image: 'assets/actors/1.jpg',
        ),
        Actor(
          name: 'Gary Carr',
          image: 'assets/actors/2.jpg',
        ),
        Actor(
          name: 'Jack Reynor',
          image: 'assets/actors/3.jpg',
        ),
        Actor(
          name: 'Louis Herthum',
          image: 'assets/actors/4.jpg',
        ),
      ],
    ),
    Movie(
      title: 'District 9',
      image: 'assets/movies/district_9.jpg',
      genres: ['Action', 'Sci-Fi', 'Thriller'],
      rate: 7.9,
      director: 'Neill Blomkamp',
      description:
          "In 1982, a massive star ship bearing a bedraggled alien population, nicknamed 'The Prawns', appeared over Johannesburg, South Africa. Twenty-eight years later, the initial welcome by the human population has faded. The refugee camp where the aliens were located has deteriorated into a militarized ghetto called District 9, where they are confined and exploited in squalor. In 2010, the munitions corporation, Multi-National United, is contracted to forcibly evict the population with operative Wikus van der Merwe in charge. In this operation, Wikus is exposed to a strange alien chemical and must rely on the help of his only two new 'Prawn' friends",
      actors: [
        Actor(
          name: 'Sharlto Copley',
          image: 'assets/actors/13.jpg',
        ),
        Actor(
          name: 'Nathalie Boltt',
          image: 'assets/actors/14.jpg',
        ),
        Actor(
          name: 'Sylvaine Strike',
          image: 'assets/actors/15.jpg',
        ),
        Actor(
          name: 'John Sumner',
          image: 'assets/actors/16.jpg',
        ),
      ],
    ),
    Movie(
      title: 'John Wick 3',
      image: 'assets/movies/john_wick_3.jpg',
      genres: ['Action', 'Crime', 'Thriller'],
      rate: 7.4,
      director: 'Chad Stahelski',
      description:
          r"In this third installment of the adrenaline-fueled action franchise, skilled assassin John Wick (Keanu Reeves) returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail. After killing a member of the shadowy international assassin's guild, the High Table, John Wick is excommunicado, but the world's most ruthless hit men and women await his every turn.",
      actors: [
        Actor(
          name: 'Keanu Reeves',
          image: 'assets/actors/9.jpg',
        ),
        Actor(
          name: 'Halle Berry',
          image: 'assets/actors/10.jpg',
        ),
        Actor(
          name: 'Ian McShane',
          image: 'assets/actors/11.jpg',
        ),
        Actor(
          name: 'Laurence Fishburne',
          image: 'assets/actors/12.jpg',
        ),
      ],
    ),
    Movie(
      title: 'Extraction',
      image: 'assets/movies/extraction.jpg',
      genres: [
        'Action',
        'Thriller',
      ],
      rate: 6.7,
      director: 'Sam Hargrave',
      description:
          "In an underworld of weapons dealers and traffickers, a young boy becomes the pawn in a war between notorious drug lords. Trapped by kidnappers inside one of the world's most impenetrable cities, his rescue beckons the unparalleled skill of a mercenary named Tyler Rake, but Rake is a broken man with nothing to lose, harboring a death wish that makes an already deadly mission near impossible.",
      actors: [
        Actor(
          name: 'Chris Hemsworth',
          image: 'assets/actors/5.jpg',
        ),
        Actor(
          name: 'Rudhraksh Jaiswal',
          image: 'assets/actors/6.jpg',
        ),
        Actor(
          name: 'Randeep Hooda',
          image: 'assets/actors/7.jpg',
        ),
        Actor(
          name: 'Neha Mahajan',
          image: 'assets/actors/8.jpg',
        ),
      ],
    ),
  ];
}
