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
  int _themeIndex = 0;

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
      _themeIndex = (prefs.getInt(resourceThemeIndex) ?? defaultThemeIndex);
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

  _setThemeIndex(int index) async {
    _themeIndex = index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DynamicTheme.of(context).setBrightness(themeBrightnesses[index]);
    setState(() {
      prefs.setInt(resourceThemeIndex, _themeIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      PopupMenuButton<double>(
        padding: EdgeInsets.zero,
        initialValue: _russianFontSize,
        onSelected: _setRussianFontSize,
        child: ListTile(
            title: const Text(resourceRussianTextSize),
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
            title: const Text(resourceArabicTextSize),
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
      PopupMenuButton<int>(
        padding: EdgeInsets.zero,
        initialValue: _themeIndex,
        onSelected: _setThemeIndex,
        child: ListTile(
            title: Text(resourceTheme),
            subtitle: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                    child:
                        CircleAvatar(backgroundColor: themeColors[_themeIndex]),
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    )))),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<int>>.generate(
                themeNames.length,
                (i) => PopupMenuItem<int>(
                      value: i,
                      child: ListTile(
                          title: Text(themeNames[i]),
                          leading: Container(
                              child:
                                  CircleAvatar(backgroundColor: themeColors[i]),
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ))),
                    )),
      )
    ]);
  }
}
