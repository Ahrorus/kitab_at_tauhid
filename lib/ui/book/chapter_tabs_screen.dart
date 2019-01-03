import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../book_resource/book.dart';
import '../../util/constants.dart';
import '../../util/globals.dart';
import 'chapter_appbar.dart';
import 'text_view.dart';

class BookTabsScreen extends StatefulWidget {
  final int position;
  BookTabsScreen({Key key, this.position}) : super(key: key);

  @override
  _BookTabsScreenState createState() => _BookTabsScreenState();
}

class _BookTabsScreenState extends State<BookTabsScreen>
    with SingleTickerProviderStateMixin {
  double _russianFontSize = defaultRussianTextSize;
  double _arabicFontSize = defaultArabicTextSize;
  String _russianFont = russianFonts[0];
  String _arabicFont = arabicFonts[0];
  ChapterAppbar _chapterAppbar;
  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[_chapterAppbar];
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
                _arabicFont),
          ],
          controller: tabController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getFontStyle();
    _scrollViewController = ScrollController();
    tabController = TabController(vsync: this, length: tabNum);
    _chapterAppbar = ChapterAppbar(position: widget.position);
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
    });
  }
}
