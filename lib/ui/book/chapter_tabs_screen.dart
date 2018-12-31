import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../book_resource/book.dart';
import '../../util/constants.dart';
import 'text_view.dart';

class BookTabsScreen extends StatefulWidget {
  final int position;
  BookTabsScreen({Key key, this.position}) : super(key: key);

  @override
  _BookTabsScreenState createState() => _BookTabsScreenState();
}

class _BookTabsScreenState extends State<BookTabsScreen>
    with SingleTickerProviderStateMixin {
  List<String> _bookmarks = List<String>.filled(chapters.length, 'false');
  double _russianFontSize = defaultRussianTextSize;
  double _arabicFontSize = defaultArabicTextSize;
  String _russianFont = russianFonts[0];
  String _arabicFont = arabicFonts[0];
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getFontStyle();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: tabNum);
  }

  _getFontStyle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _russianFontSize =
          (prefs.getDouble(resourceRussianFontSize) ?? defaultRussianTextSize);
      _arabicFontSize =
          (prefs.getDouble(resourceArabicFontSize) ?? defaultArabicTextSize);
      _russianFont = (prefs.getString(resourceRussianFont) ?? russianFonts[0]);
      _arabicFont = (prefs.getString(resourceArabicFont) ?? arabicFonts[0]);
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
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              title: Text(resourceChapter +
                  (widget.position + 1).toString() +
                  ' / ' +
                  chapters.length.toString()),
              actions: <Widget>[
                Checkbox(
                    value:
                        (_bookmarks[widget.position] == 'false') ? false : true,
                    onChanged: (value) {
                      _setBookmark(widget.position);
                    }),
              ],
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(text: resourceMatnRussian),
                  Tab(
                    text: resourceMatnArabic,
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            TextView(
                chapters[widget.position].russianTitle,
                chapters[widget.position].russianMatn,
                _russianFontSize,
                _russianFont),
            TextView(
                chapters[widget.position].arabicTitle,
                chapters[widget.position].arabicMatn,
                _arabicFontSize,
                _arabicFont)
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
