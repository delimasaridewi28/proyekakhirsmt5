import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vilm/login.dart';
import 'package:vilm/profile.dart';

void main() {
  runApp(LoginApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Terbaru',
      theme: ThemeData(
        primaryColor:
            Color(0xFFF2A531), // Mengubah warna top bar menjadi kuning
        scaffoldBackgroundColor: Color(0xFFF2A531),
      ),
      home: Scaffold(
        body: SafeArea(
          child: FilmList(),
        ),
      ),
    );
  }
}

class FilmList extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  List<dynamic> films = [];

  @override
  void initState() {
    super.initState();
    fetchFilmData();
  }

  Future<void> fetchFilmData() async {
    String apiKey =
        '84871b4e0d9df1d656b477982e81acd4'; // Ganti dengan API key Anda dari TheMovieDB
    String url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        films = data['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03032A),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFFF2A531), // Warna latar belakang container
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0), // Rounded sudut kiri bawah
                  bottomRight:
                      Radius.circular(16.0), // Rounded sudut kanan bawah
                ),
              ), // Warna latar belakang container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vilm',
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                    icon : CircleAvatar(
                      backgroundImage: AssetImage('assets/stitch.jpg'),
                      radius: 20,
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8.0),
              itemCount: films.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FilmItem(film: films[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilmItem extends StatelessWidget {
  final dynamic film;

  FilmItem({required this.film});

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500${film['poster_path']}';

    return Container(
      color: Color(
          0xFF03032A), // Mengatur latar belakang Container menjadi transparan
      child: Card(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMovieScreen(film: film),
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
                  film['title'],
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

class DetailMovieScreen extends StatelessWidget {
  final dynamic film;

  DetailMovieScreen({required this.film});

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500${film['poster_path']}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF03032A),
        title: Text('Detail Film'),
      ),
      backgroundColor: Color(0xFF03032A),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 300.0,
              ),
              SizedBox(height: 16.0),
              Text(
                film['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Release Date: ${film['release_date']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Rating: ${film['vote_average']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Overview:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                film['overview'],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
