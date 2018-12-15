import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../book/chapters.dart';
import '../util/constants.dart';

class BookTabsScreen extends StatefulWidget {
  final int position;
  BookTabsScreen({Key key, this.position}) : super(key: key);

  @override
  _BookTabsScreenState createState() => _BookTabsScreenState();
}

class _BookTabsScreenState extends State<BookTabsScreen>
    with SingleTickerProviderStateMixin {
  double _russianFontSize;
  double _arabicFontSize;
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
          (prefs.getDouble(resourceRussianFontSize) ?? defaultTextSize);
      _arabicFontSize =
          (prefs.getDouble(resourceArabicFontSize) ?? defaultTextSize);
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
              title: Text(resourceChapter + (widget.position + 1).toString()),
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
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
            showText(chapters[widget.position].russianTitle,
                chapters[widget.position].russianMatn, _russianFontSize),
            showText(chapters[widget.position].arabicTitle,
                chapters[widget.position].arabicMatn, _arabicFontSize)
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

StatelessWidget showText(String header, String text, double fontSize) {
  return ListView(
    children: <Widget>[
      Container(
          padding: EdgeInsets.only(
              left: textEdgeInset, top: textEdgeInset, right: textEdgeInset),
          child: Text(
            header,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize * 1.2, fontWeight: FontWeight.w900),
          )),
      Html(
        data: text,
//Optional parameters:
        padding: EdgeInsets.all(textEdgeInset),
        defaultTextStyle: TextStyle(
          fontSize: fontSize,
        ),
      ),
    ],
  );
}
