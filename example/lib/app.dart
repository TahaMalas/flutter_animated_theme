import 'package:flutter/material.dart';
import 'package:flutter_animated_theme/animated_theme_app.dart';
import 'package:flutter_animated_theme/animation_type.dart';
import 'package:flutter_animated_theme_example/home_page.dart';
import 'package:flutter_animated_theme_example/theme_colors.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedThemeApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      animationDuration: Duration(milliseconds: 2000),
      animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: ThemeColors.startLightColor,
        accentColor: ThemeColors.endLightColor,
        hintColor: ThemeColors.buttonLightColor,
        backgroundColor: ThemeColors.actionBackgroundLightColor,
        buttonColor: ThemeColors.textButtonLightColor,
        toggleableActiveColor: ThemeColors.iconLightColor,
        canvasColor: ThemeColors.iconSecondaryLightColor,
        cursorColor: ThemeColors.starNotFilledLight,

        iconTheme: IconThemeData(
          color: ThemeColors.iconLightColor,
        ),
        textTheme: TextTheme(
          body1: TextStyle(
            color: ThemeColors.textLightColor,
          ),
          button: TextStyle(
            color: ThemeColors.textButtonLightColor,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: ThemeColors.startDarkColor,
        accentColor: ThemeColors.endDarkColor,
        hintColor: ThemeColors.buttonDarkColor,
        backgroundColor: ThemeColors.actionBackgroundDarkColor,
        buttonColor: ThemeColors.textButtonDarkColor,
        toggleableActiveColor: ThemeColors.iconDarkColor,
        canvasColor: ThemeColors.iconSecondaryDarkColor,
        cursorColor: ThemeColors.starNotFilledDark,
        iconTheme: IconThemeData(
          color: ThemeColors.iconDarkColor,
        ),
        textTheme: TextTheme(
          body1: TextStyle(
            color: ThemeColors.textDarkColor,
          ),
          button: TextStyle(
            color: ThemeColors.textButtonDarkColor,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
