// film_item.dart
import 'package:flutter/material.dart';
import '../models/film_models.dart';
import 'detail_movie_screen.dart';

class FilmItem extends StatelessWidget {
  final Film film;

  FilmItem({required this.film});

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500${film.posterPath}';

    return Container(
      color: Color(0xFF03032A),
      child: Card(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMovieScreen(movieId: film.id),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  film.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
