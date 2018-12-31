import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../book_resource/book.dart';
import '../../util/constants.dart';
import 'chapter_tabs_screen.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<String> _bookmarks = List<String>.filled(chapters.length, 'false');

  @override
  void initState() {
    super.initState();
    _getBookmarks();
  }

  _getBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarks = (prefs.getStringList(resourceBookmarks) ??
          List<String>.filled(chapters.length, 'false'));
    });
  }

  _setBookmark(int chapterIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_bookmarks[chapterIndex] == 'false') {
        _bookmarks[chapterIndex] = 'true';
      } else {
        _bookmarks[chapterIndex] = 'false';
      }
      prefs.setStringList(resourceBookmarks, _bookmarks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                title: Text(
                  chapters[position].russianTitle,
                  style: TextStyle(fontSize: defaultRussianTextSize),
                ),
                subtitle: Text(chapters[position].arabicTitle,
                    style: TextStyle(fontSize: defaultArabicTextSize)),
                leading: CircleAvatar(
                    child: Text((position + 1).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    backgroundColor: (_bookmarks[position] == 'true')
                        ? bookmarkColor
                        : primaryColor),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookTabsScreen(position: position)),
                    ),
                onLongPress: () {
                  _setBookmark(position);
                },
              );
            }));
  }
}
