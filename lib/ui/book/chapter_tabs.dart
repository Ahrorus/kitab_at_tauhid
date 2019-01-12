import 'package:flutter/material.dart';

import '../../book_resource/book.dart';
import '../../util/book_shared_preferences.dart';
import '../../util/constants.dart';
import 'chapter_audio_list.dart';
import 'text_view.dart';

List<Widget> getChapterTabBodies(
    int chapterIndex, double russianFontSize, double arabicFontSize) {
  List<Widget> tabBodies = [];

  List<Widget> defaultTabBodies = [
    TextView(chapters[chapterIndex].russianTitle,
        chapters[chapterIndex].russianMatn, russianFontSize),
    TextView(chapters[chapterIndex].arabicTitle,
        chapters[chapterIndex].arabicMatn, arabicFontSize),
    TextView('1', '1', russianFontSize),
    AudioList(),
  ];

  for (int i = 0; i < tabNum; i++) {
    tabBodies.add(defaultTabBodies[tabsOrder[i]]);
  }

  return tabBodies;
}

List<Tab> getChapterTabs() {
  List<Tab> tabs = [];

  List<Tab> defaultTabs = [
    Tab(text: resourceMatnRussian),
    Tab(
      text: resourceMatnArabic,
    ),
    Tab(text: resourceSharhRussian),
    Tab(
      text: resourceAudio,
    ),
  ];

  for (int i = 0; i < tabNum; i++) {
    tabs.add(defaultTabs[tabsOrder[i]]);
  }

  return tabs;
}
