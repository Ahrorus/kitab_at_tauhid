import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../book/chapter.dart';

class BookTabsScreen extends StatefulWidget {
  final int position;
  BookTabsScreen({Key key, this.position}) : super(key: key);

  @override
  _BookTabsScreenState createState() => _BookTabsScreenState();
}

class _BookTabsScreenState extends State<BookTabsScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: 2);
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
              title: Text(chapters[widget.position].russianTitle),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(text: 'Матн'),
                  Tab(
                    text: 'متن',
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            showText(chapters[widget.position].russianMatn),
            showText(chapters[widget.position].russianMatn)
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

StatelessWidget showText(String text) {
  return SingleChildScrollView(
    child: Html(
      data: text,
//Optional parameters:
      padding: EdgeInsets.all(8.0),
      defaultTextStyle: TextStyle(
        fontSize: 16.0,
      ),
    ),
  );
}
