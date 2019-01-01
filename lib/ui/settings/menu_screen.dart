import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    super.initState();
    _getSharedPreferences();
  }

  _getSharedPreferences() async {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[

    ]);
  }
}
