import 'package:dynamic_theme/dynamic_theme.dart';
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
              title: Text(
                  '${widget.position + 1} / ${chapters.length.toString()}'),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      _goToPage(widget.position - 1);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: () {
                      _goToPage(widget.position + 1);
                    },
                    icon: Icon(Icons.arrow_forward_ios)),
                PopupMenuButton(
                  child: const Icon(Icons.text_fields),
                  itemBuilder: (_) => <PopupMenuItem<String>>[
                        new PopupMenuItem<String>(
                            child: PopupMenuButton<double>(
                              padding: EdgeInsets.zero,
                              initialValue: _russianFontSize,
                              onSelected: _setRussianFontSize,
                              child: ListTile(
                                  title: Text(resourceRussianTextSize)),
                              itemBuilder: (BuildContext context) =>
                                  List<PopupMenuItem<double>>.generate(
                                      fontSizes.length,
                                      (i) => PopupMenuItem<double>(
                                          value: fontSizes[i],
                                          child: Text(
                                            resourceRussianBasmala,
                                            style: TextStyle(
                                                fontSize: fontSizes[i],
                                                fontFamily: _russianFont),
                                          ))),
                            ),
                            value: resourceRussianTextSize),
                        new PopupMenuItem<String>(
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              initialValue: _russianFont,
                              onSelected: _setRussianFont,
                              child: ListTile(
                                  title: Text(resourceRussianTextFont)),
                              itemBuilder: (BuildContext context) =>
                                  List<PopupMenuItem<String>>.generate(
                                      russianFonts.length,
                                      (i) => PopupMenuItem<String>(
                                          value: russianFonts[i],
                                          child: Text(
                                            resourceRussianBasmala,
                                            style: TextStyle(
                                                fontFamily: russianFonts[i],
                                                fontSize: _russianFontSize),
                                          ))),
                            ),
                            value: resourceRussianTextFont),
                        new PopupMenuItem<String>(
                            child: new PopupMenuButton<double>(
                              padding: EdgeInsets.zero,
                              initialValue: _arabicFontSize,
                              onSelected: _setArabicFontSize,
                              child:
                                  ListTile(title: Text(resourceArabicTextSize)),
                              itemBuilder: (BuildContext context) =>
                                  List<PopupMenuItem<double>>.generate(
                                      fontSizes.length,
                                      (i) => PopupMenuItem<double>(
                                          value: fontSizes[i],
                                          child: Text(
                                            resourceArabicBasmala,
                                            style: TextStyle(
                                                fontSize: fontSizes[i],
                                                fontFamily: _arabicFont),
                                          ))),
                            ),
                            value: resourceArabicTextSize),
                        new PopupMenuItem<String>(
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              initialValue: _arabicFont,
                              onSelected: _setArabicFont,
                              child:
                                  ListTile(title: Text(resourceArabicTextFont)),
                              itemBuilder: (BuildContext context) =>
                                  List<PopupMenuItem<String>>.generate(
                                      arabicFonts.length,
                                      (i) => PopupMenuItem<String>(
                                          value: arabicFonts[i],
                                          child: Text(
                                            resourceArabicBasmala,
                                            style: TextStyle(
                                                fontFamily: arabicFonts[i],
                                                fontSize: _arabicFontSize),
                                          ))),
                            ),
                            value: resourceArabicTextFont),
                      ],
                  onSelected: (_) {},
                ),
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
                IconButton(
                    onPressed: () {
                      _setBookmark(widget.position);
                    },
                    icon: (_bookmarks[widget.position] == 'false')
                        ? Icon(Icons.bookmark_border)
                        : Icon(Icons.bookmark)),
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
                _arabicFont),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

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

  _goToPage(index) {
    if (index >= 0 && index < chapters.length)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BookTabsScreen(position: index)),
      );
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

  _setRussianFontSize(double size) async {
    if (fontSizes.contains(size)) {
      _russianFontSize = size;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setDouble(resourceRussianFontSize, _russianFontSize);
      });
    }
  }

  _setArabicFontSize(double size) async {
    if (fontSizes.contains(size)) {
      _arabicFontSize = size;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setDouble(resourceArabicFontSize, _arabicFontSize);
      });
    }
  }

  _setRussianFont(String font) async {
    if (russianFonts.contains(font)) {
      _russianFont = font;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString(resourceRussianFont, _russianFont);
      });
    }
  }

  _setArabicFont(String font) async {
    if (arabicFonts.contains(font)) {
      _arabicFont = font;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString(resourceArabicFont, _arabicFont);
      });
    }
  }
}
