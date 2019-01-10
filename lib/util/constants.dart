import 'package:flutter/material.dart';

const double defaultRussianTextSize = 16.0;
const double highlightedRussianTextSize = 20.0;
const double defaultArabicTextSize = 18.0;
const double chapterAppBarTextSize = 18.0;
const textRowHeight = 1.2;

const double minTextSize = 10.0;
const double maxTextSize = 30.0;
const textSizeStep = 2.0;

const List<String> lecturers = ['Лектор 1', 'Лектор 2', 'Лектор 3'];
const double tabTextEdgeInset = 4.0;
const double textEdgeInset = 8.0;
const double buttonEdgeInset = 32.0;
const int tabNum = 4;
List<int> defaultTabsOrder = [0, 1, 2, 3];
List<String> defaultTabsNamesOrder = [
  '$resourceMatnRussian ($resourceMatnRussianExplanation)',
  '$resourceMatnArabic ($resourceMatnArabicExplanation)',
  '$resourceSharhRussian ($resourceSharhRussianExplanation)',
  resourceAudio
];
const String tab0 = 'tab0';
const String tab1 = 'tab1';
const String tab2 = 'tab2';
const String tab3 = 'tab3';

const String resourceRussianFontSize = 'russianFontSize';
const String resourceArabicFontSize = 'arabicFontSize';
const String resourceBookmarks = 'bookmarks';
const String resourceRussianTextSize = 'Русский текст';
const String resourceArabicTextSize = 'Арабский текст';
const String resourceTheme = 'Тема оформления';

const String resourceAudio = 'Аудио';
const String resourceBook = 'Книга';
const String resourceSettings = 'Меню';

const String resourceMatnRussian = 'Матн';
const String resourceMatnArabic = 'متن';
const String resourceSharhRussian = 'Шарх';
const String resourceMatnRussianExplanation = 'текст книги на русском';
const String resourceMatnArabicExplanation = 'текст книги на арабском';
const String resourceSharhRussianExplanation = 'разьяснение книги на русском';
const String resourceChooseTabOrder = 'Изменить порядок вкладок в главе';
const String resourceDragAndDropTabs = 'Перетащите элементы';

Color primaryColor = Colors.indigo;
