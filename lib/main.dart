import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';
import 'util/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: themeBrightnesses[0],
        data: (brightness) => new ThemeData(
              primarySwatch: primaryColor,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Kitab at-Tauhid',
            theme: theme,
            home: Home(title: 'Kitab at-Tauhid'),
          );
        });
  }
}
