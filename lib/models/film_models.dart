// models.dart
class Film {
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String overview;
  final String posterPath;

  Film({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.overview,
    required this.posterPath,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
