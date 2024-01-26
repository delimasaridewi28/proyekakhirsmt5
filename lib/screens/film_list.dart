// film_list.dart
import 'package:flutter/material.dart';
import '../controller/film_controller.dart';
import '../models/film_models.dart';
import 'film_item.dart';
import 'profile.dart';
import 'login.dart';

class FilmList extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  List<Film> films = [];

  @override
  void initState() {
    super.initState();
    _fetchFilmData();
  }

  Future<void> _fetchFilmData() async {
    try {
      List<Film> fetchedFilms = await FilmController().fetchFilmData();
      setState(() {
        films = fetchedFilms;
      });
    } catch (e) {
      print('Error fetching film data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    int crossAxisCount = isDesktop ? 4 : 2;

    return Scaffold(
      backgroundColor: Color(0xFF03032A),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFFF2A531),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vilm',
                    style: TextStyle(
                      color: Colors.white,
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
                crossAxisCount: crossAxisCount,
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
