import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _russianFontSize = defaultTextSize;
  double _arabicFontSize = defaultTextSize;
  String _russianFont = russianFonts[0];
  String _arabicFont = arabicFonts[0];

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
      _russianFont = (prefs.getString(resourceRussianFont) ?? russianFonts[0]);
      _arabicFont = (prefs.getString(resourceArabicFont) ?? arabicFonts[0]);
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

  _setRussianFont(String font) async {
    if (russianFonts.contains(font)) {
      _russianFont = font;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString(resourceRussianFont, _russianFont);
      });
    }
  }

  _setArabicFont(String font) async {
    if (arabicFonts.contains(font)) {
      _arabicFont = font;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString(resourceArabicFont, _arabicFont);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
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
      PopupMenuButton<double>(
        padding: EdgeInsets.zero,
        initialValue: _russianFontSize,
        onSelected: _setRussianFontSize,
        child: ListTile(
            title: Text(resourceRussianTextSize),
            subtitle: Text(
              resourceRussianBasmala,
              style: TextStyle(
                  fontSize: _russianFontSize, fontFamily: _russianFont),
            )),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<double>>.generate(
                fontSizes.length,
                (i) => PopupMenuItem<double>(
                    value: fontSizes[i],
                    child: Text(
                      resourceRussianBasmala,
                      style: TextStyle(
                          fontSize: fontSizes[i], fontFamily: _russianFont),
                    ))),
      ),
      PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        initialValue: _russianFont,
        onSelected: _setRussianFont,
        child: ListTile(
            title: Text(resourceRussianTextFont),
            subtitle: Text(
              resourceRussianBasmala,
              style: TextStyle(
                  fontFamily: _russianFont, fontSize: _russianFontSize),
            )),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<String>>.generate(
                russianFonts.length,
                (i) => PopupMenuItem<String>(
                    value: russianFonts[i],
                    child: Text(
                      resourceRussianBasmala,
                      style: TextStyle(
                          fontFamily: russianFonts[i],
                          fontSize: _russianFontSize),
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
              style:
                  TextStyle(fontSize: _arabicFontSize, fontFamily: _arabicFont),
            )),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<double>>.generate(
                fontSizes.length,
                (i) => PopupMenuItem<double>(
                    value: fontSizes[i],
                    child: Text(
                      resourceArabicBasmala,
                      style: TextStyle(
                          fontSize: fontSizes[i], fontFamily: _arabicFont),
                    ))),
      ),
      PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        initialValue: _arabicFont,
        onSelected: _setArabicFont,
        child: ListTile(
            title: Text(resourceArabicTextFont),
            subtitle: Text(
              resourceArabicBasmala,
              style:
                  TextStyle(fontFamily: _arabicFont, fontSize: _arabicFontSize),
            )),
        itemBuilder: (BuildContext context) =>
            List<PopupMenuItem<String>>.generate(
                arabicFonts.length,
                (i) => PopupMenuItem<String>(
                    value: arabicFonts[i],
                    child: Text(
                      resourceArabicBasmala,
                      style: TextStyle(
                          fontFamily: arabicFonts[i],
                          fontSize: _arabicFontSize),
                    ))),
      ),
    ]);
  }
}
