import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _russianFontSize;
  double _arabicFontSize;

  @override
  void initState() {
    super.initState();
    _getSharedPreferences();
  }

  _getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _russianFontSize =
          (prefs.getDouble(resourceRussianFontSize) ?? defaultTextSize);
      _arabicFontSize =
          (prefs.getDouble(resourceArabicFontSize) ?? defaultTextSize);
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

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      PopupMenuButton<double>(
        padding: EdgeInsets.zero,
        initialValue: _russianFontSize,
        onSelected: _setRussianFontSize,
        child: ListTile(
            title: Text(resourceRussianTextSize),
            subtitle: Text(
              resourceRussianBasmala,
              style: TextStyle(fontSize: _russianFontSize),
            )),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<double>>.generate(
                fontSizes.length,
                (i) => PopupMenuItem<double>(
                    value: fontSizes[i],
                    child: Text(
                      resourceRussianBasmala,
                      style: TextStyle(fontSize: fontSizes[i]),
                    ))),
      ),
      PopupMenuButton<double>(
        padding: EdgeInsets.zero,
        initialValue: _arabicFontSize,
        onSelected: _setArabicFontSize,
        child: ListTile(
            title: Text(resourceArabicTextSize),
            subtitle: Text(
              resourceArabicBasmala,
              style: TextStyle(fontSize: _arabicFontSize),
            )),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<double>>.generate(
                fontSizes.length,
                (i) => PopupMenuItem<double>(
                    value: fontSizes[i],
                    child: Text(
                      resourceArabicBasmala,
                      style: TextStyle(fontSize: fontSizes[i]),
                    ))),
      ),
    IconButton(
    icon: Icon(Icons.brightness_6),
    onPressed: (){
//      It is possible to change whole theme https://github.com/Norbert515/dynamic_theme
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
    },
    )
    ]);
  }
}
