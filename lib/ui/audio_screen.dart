import 'package:flutter/material.dart';

import '../util/constants.dart';

class AudioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight),
          child: Container(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    tabs: [
                      tabText(lecturers[0]),
                      tabText(lecturers[1]),
                      tabText(lecturers[2])
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Text(""),
            Text(""),
            Text(""),
          ],
        ),
      ), // See the next step!
    );
  }
}

StatelessWidget tabText(String text) {
  return Container(
      padding: EdgeInsets.only(bottom: tabTextEdgeInset, top: tabTextEdgeInset),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.blue),
      ));
}
