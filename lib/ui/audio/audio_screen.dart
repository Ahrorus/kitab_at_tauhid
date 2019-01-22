import 'package:flutter/material.dart';

import '../../util/constants.dart';
import 'lector_one_tab.dart';
import 'lector_two_tab.dart';
import 'lector_three_tab.dart';


class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
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
                      TabText(lecturers[0]),
                      TabText(lecturers[1]),
                      TabText(lecturers[2])
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            LectorOneTab(),
            LectorTwoTab(),
            LectorThreeTab(),
          ],
        ),
      ), // See the next step!
    );
  }
}


/*
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
                      TabText(lecturers[0]),
                      TabText(lecturers[1]),
                      TabText(lecturers[2])
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
*/

class TabText extends StatelessWidget {
  final String text;
  TabText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(bottom: tabTextEdgeInset, top: tabTextEdgeInset),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue),
        ));
  }
}
