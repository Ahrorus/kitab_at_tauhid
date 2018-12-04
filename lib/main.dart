import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kitab at-Tauhid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Kitab at-Tauhid'),
    );
  }
}
