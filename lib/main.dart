import 'package:flutter/material.dart';
import 'package:music_app_fancy_animation/screens/albums_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: AlbumsListScreen(),
    );
  }
}
