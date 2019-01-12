import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../book_resource/book.dart';
import 'constants.dart';

List<String> bookmarks = List<String>.filled(chapters.length, 'false');
double russianFontSize = defaultRussianTextSize;
double arabicFontSize = defaultArabicTextSize;
List<int> tabsOrder = defaultTabsOrder;

mixin BookSharedPreferences<T extends StatefulWidget> on State<T> {
  setBookmark(int chapterIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (bookmarks[chapterIndex] == 'false') {
        bookmarks[chapterIndex] = 'true';
      } else {
        bookmarks[chapterIndex] = 'false';
      }
      prefs.setStringList(resourceBookmarks, bookmarks);
    });
  }

  getBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarks = (prefs.getStringList(resourceBookmarks) ??
          List<String>.filled(chapters.length, 'false'));
    });
  }

  setRussianFontSize(double size) async {
    if (size > minTextSize && size < maxTextSize) {
      russianFontSize = size;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setDouble(resourceRussianFontSize, russianFontSize);
      });
    }
  }

  setArabicFontSize(double size) async {
    if (size > minTextSize && size < maxTextSize) {
      arabicFontSize = size;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setDouble(resourceArabicFontSize, arabicFontSize);
      });
    }
  }

  getFontSizes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      russianFontSize =
          (prefs.getDouble(resourceRussianFontSize) ?? defaultRussianTextSize);
      arabicFontSize =
          (prefs.getDouble(resourceArabicFontSize) ?? defaultArabicTextSize);
    });
  }

  getTabsOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tabsOrder[0] = (prefs.getInt(tab0) ?? defaultTabsOrder[0]);
    tabsOrder[1] = (prefs.getInt(tab1) ?? defaultTabsOrder[1]);
    tabsOrder[2] = (prefs.getInt(tab2) ?? defaultTabsOrder[2]);
    tabsOrder[3] = (prefs.getInt(tab3) ?? defaultTabsOrder[3]);
  }

  setTabsOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(tab0, tabsOrder[0]);
    prefs.setInt(tab1, tabsOrder[1]);
    prefs.setInt(tab2, tabsOrder[2]);
    prefs.setInt(tab3, tabsOrder[3]);
  }
}
