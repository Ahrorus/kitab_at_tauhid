import 'package:flutter/material.dart';

import 'audio_screen.dart';
import 'book_screen.dart';
import 'settings_screen.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    AudioScreen(),
    BookScreen(),
    SettingsScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            title: Text('Аудио'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Книга'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Настройки'))
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
