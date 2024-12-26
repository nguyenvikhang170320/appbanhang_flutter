import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
      child: Text("Mục yêu thích"),
    );
  }
}
