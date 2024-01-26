import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/film_models.dart';

class DetailMovieScreen extends StatelessWidget {
  final int movieId;

  DetailMovieScreen({required this.movieId});

  Future<Film> fetchMovieDetails() async {
    try {
      String apiKey = '84871b4e0d9df1d656b477982e81acd4';
      String apiUrl = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return Film.fromJson(json.decode(response.body));
      } else {
        print('Failed to load movie details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load movie details');
      }
    } catch (error, stacktrace) {
      print('Error during API request: $error');
      print('Stacktrace: $stacktrace');
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Film>(
      future: fetchMovieDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final Film film = snapshot.data!;
          final double fem = MediaQuery.of(context).size.width / 360;
          final double ffem = MediaQuery.of(context).size.height / 640;

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(14 * fem, 18 * fem, 16 * fem, 164 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff050a23),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 267 * fem, 39 * fem),
                    padding: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 0 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 0 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 222 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16 * fem),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${film.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 32 * fem),
                        Text(
                          film.title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                            color: Color(0xffffffff),
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 16 * fem),
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 16 * fem, 2 * fem),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                        child: Text(
                                          '2023',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                            color: Color(0xffffffff),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 4 * fem,
                                        height: 4 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2 * fem),
                                          color: Color(0x99ffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  // ... your existing code
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16 * fem),
                  Container(
                    constraints: BoxConstraints(maxWidth: 328 * fem),
                    child: Text(
                      film.overview,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 2.4,
                        color: Color(0xccffffff),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
