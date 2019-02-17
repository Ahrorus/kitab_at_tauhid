import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:kitab_at_tauhid/ui/book/book_screen.dart';
import 'package:kitab_at_tauhid/ui/settings/menu_screen.dart';

import '../util/constants.dart';
import 'audio/audio_screen.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  final List<Widget> _children = [AudioScreen(), BookScreen(), MenuScreen()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // ********Audio Part*********



  // ********Audio Ends*********

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
//      It is possible to change whole theme https://github.com/Norbert515/dynamic_theme
              DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            title: Text(resourceAudio),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text(resourceBook),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text(resourceSettings))
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
