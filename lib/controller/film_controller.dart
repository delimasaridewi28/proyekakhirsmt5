import 'package:dio/dio.dart';
import '../models/film_models.dart';

class FilmController {

Future<List<Film>> fetchFilmData() async {
  try {
    String apiKey = '84871b4e0d9df1d656b477982e81acd4';
    String apiUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

    Response response = await Dio().get(apiUrl);

    if (response.statusCode == 200) {
      var data = response.data;
      List<dynamic> filmsData = data['results'];
      return filmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
    } else {
      throw Exception('Failed to load film data');
    }
  } catch (error) {
    print('Error during API request: $error');
    throw Exception('Failed to load film data');
  }
}

}
