import 'package:flutter/material.dart';
import 'm7_modul.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    String nama = "Titu";
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Ini Pagee pertama"),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage(nama: nama)),
                ), 
                child: Text("Go to second"),
            ),
          ],
          ),
          ),
          );
  }
}

class SecondPage extends StatelessWidget {
  final String nama;
  const SecondPage({super.key, required this.nama, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
        child: Column(
          children: [
            Text("Ini Pagee kedua"),
            Text("Nama saya $nama"),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstPage()),
                ), 
                child: Text("Back to First Page"),
            ),
          ],
          ),
          ),
          );
  } 
  }