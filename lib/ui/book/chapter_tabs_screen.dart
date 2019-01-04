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
                IconButton(
                  icon: Icon(Icons.text_fields),
                  onPressed: () {
_showTextSizeDialog();
                  },
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
                _russianFontSize),
            TextView(
                chapters[widget.position].arabicTitle,
                chapters[widget.position].arabicMatn,
                _arabicFontSize),
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
    if(size > minTextSize && size < maxTextSize) {
      _russianFontSize = size;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setDouble(resourceRussianFontSize, _russianFontSize);
      });
    }
  }

  _setArabicFontSize(double size) async {
    if(size > minTextSize && size < maxTextSize) {
      _arabicFontSize = size;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setDouble(resourceArabicFontSize, _arabicFontSize);
      });
    }
  }

  _showTextSizeDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: CircleAvatar(
                      child: Text(('-').toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      _setRussianFontSize(_russianFontSize - textSizeStep);
                    },
                  ),
                  Expanded(child: Container(
                      alignment: Alignment.center,
                      child: Text(resourceRussianTextSize))),
                  IconButton(
                    icon: CircleAvatar(
                      child: Text(('+').toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      _setRussianFontSize(_russianFontSize + textSizeStep);
                    },
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: CircleAvatar(
                      child: Text(('-').toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      _setArabicFontSize(_arabicFontSize - textSizeStep);
                    },
                  ),
                  Expanded(child: Container(
                      alignment: Alignment.center,
                      child: Text(resourceArabicTextSize))),
                  IconButton(
                    icon: CircleAvatar(
                      child: Text(('+').toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      _setArabicFontSize(_arabicFontSize + textSizeStep);
                    },
                  )
                ],
              )
            ],
          );});
  }
}
