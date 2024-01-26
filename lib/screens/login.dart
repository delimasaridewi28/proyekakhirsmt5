import 'package:flutter/material.dart';
import 'package:vilm/main.dart';
import 'film_list.dart';


class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03032A),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/logo_kuning.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color.fromARGB(255, 8, 18, 46),
                border: InputBorder.none, // Menghilangkan border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none, // Menghilangkan border
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color.fromARGB(255, 8, 18, 46),
                border: InputBorder.none, // Menghilangkan border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none, // Menghilangkan border
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            Container(
              width:
                  double.infinity, // Lebar tombol mengisi seluruh lebar layar
              height: 50.0, // Tinggi tombol
              child: ElevatedButton(
                onPressed: () {
                  // Lakukan pengecekan login di sini
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email == 'admin@gmail.com' && password == 'admin123') {
                    // Jika login berhasil
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilmList(),
                      ),
                    );
                  } else {
                    // Jika login gagal
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Login Gagal'),
                          content: Text('Email atau password salah.'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFFF2A531), // Mengubah warna menjadi kuning
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}