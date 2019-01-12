import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../../book_resource/book.dart';
import '../../util/book_shared_preferences.dart';
import '../../util/constants.dart';
import 'chapter_tabs.dart';

class ChapterTabsScreen extends StatefulWidget {
  final int chapterIndex;
  ChapterTabsScreen({Key key, this.chapterIndex}) : super(key: key);

  @override
  _ChapterTabsScreenState createState() => _ChapterTabsScreenState();
}

class _ChapterTabsScreenState extends State<ChapterTabsScreen>
    with SingleTickerProviderStateMixin, BookSharedPreferences {
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
                '${widget.chapterIndex + 1} / ${chapters.length}',
                style: TextStyle(fontSize: chapterAppBarTextSize),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      _goToPage(widget.chapterIndex - 1);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: () {
                      _goToPage(widget.chapterIndex + 1);
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
                      setBookmark(widget.chapterIndex);
                    },
                    icon: (bookmarks[widget.chapterIndex] == 'false')
                        ? Icon(Icons.bookmark_border)
                        : Icon(Icons.bookmark)),
              ],
              bottom: TabBar(
                tabs: getChapterTabs(),
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: getChapterTabBodies(
              widget.chapterIndex, russianFontSize, arabicFontSize),
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
    getFontSizes();
    getTabsOrder();
    getBookmarks();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: tabNum);
  }

  _goToPage(index) {
    if (index >= 0 && index < chapters.length)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChapterTabsScreen(chapterIndex: index)),
      );
  }

  _showTextSizeDialog() {
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
                      setRussianFontSize(russianFontSize - textSizeStep);
                    },
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(resourceRussianTextSize))),
                  IconButton(
                    icon: CircleAvatar(
                      child: Text(('+').toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      setRussianFontSize(russianFontSize + textSizeStep);
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
                      setArabicFontSize(arabicFontSize - textSizeStep);
                    },
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(resourceArabicTextSize))),
                  IconButton(
                    icon: CircleAvatar(
                      child: Text(('+').toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      setArabicFontSize(arabicFontSize + textSizeStep);
                    },
                  )
                ],
              )
            ],
          );
        });
  }
}
