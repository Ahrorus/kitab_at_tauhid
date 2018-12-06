import 'package:flutter/material.dart';

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
                      tabText("Лектор 1"),
                      tabText("Лектор 2"),
                      tabText("Лектор 3")
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
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.blue, fontSize: 16.0),
      ));
}
