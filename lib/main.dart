import 'package:exploreCorner/CustomNavBar.dart';
import 'package:exploreCorner/favorites.dart';
import 'package:exploreCorner/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List<Widget> _views = [
    new Home(),
    new Favorites(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explorer',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: new Scaffold(
        body: _views[_currentIndex],
        bottomNavigationBar: new CustomnavBar(
            onTap: (i) {
              _updateIndex(i);
            },
            items: [
              new CustomItemNavBar(icon: Icons.explore, label: "Explore"),
              new CustomItemNavBar(icon: Icons.favorite, label: "Favorites")
            ]),
      ),
    );
  }

  void _updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
