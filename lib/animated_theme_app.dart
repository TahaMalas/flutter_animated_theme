// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_theme/animation_type.dart';
import 'package:flutter_animated_theme/circular_animation/circular_animated_theme.dart';
import 'package:flutter_animated_theme/fade_animation/fade_animated_theme.dart';
import 'package:flutter_animated_theme/scale_animation/scale_animated_theme.dart';

/// [AnimatedThemeApp] uses this [TextStyle] as its [DefaultTextStyle] to encourage
/// developers to be intentional about their [DefaultTextStyle].
///
/// In Material Design, most [Text] widgets are contained in [Material] widgets,
/// which sets a specific [DefaultTextStyle]. If you're seeing text that uses
/// this text style, consider putting your text in a [Material] widget (or
/// another widget that sets a [DefaultTextStyle]).
const TextStyle _errorTextStyle = TextStyle(
  color: Color(0xD0FF0000),
  fontFamily: 'monospace',
  fontSize: 48.0,
  fontWeight: FontWeight.w900,
  decoration: TextDecoration.underline,
  decorationColor: Color(0xFFFFFF00),
  decorationStyle: TextDecorationStyle.double,
  debugLabel: 'fallback style; consider putting your text in a Material',
);

/// An application that uses material design.
///
/// A convenience widget that wraps a number of widgets that are commonly
/// required for material design applications. It builds upon a [WidgetsApp] by
/// adding material-design specific functionality, such as [custom.ScaleAnimatedTheme] and
/// [GridPaper].
///
/// The [AnimatedThemeApp] configures the top-level [Navigator] to search for routes
/// in the following order:
///
///  1. For the `/` route, the [home] property, if non-null, is used.
///
///  2. Otherwise, the [routes] table is used, if it has an entry for the route.
///
///  3. Otherwise, [onGenerateRoute] is called, if provided. It should return a
///     non-null value for any _valid_ route not handled by [home] and [routes].
///
///  4. Finally if all else fails [onUnknownRoute] is called.
///
/// If a [Navigator] is created, at least one of these options must handle the
/// `/` route, since it is used when an invalid [initialRoute] is specified on
/// startup (e.g. by another application launching this one with an intent on
/// Android; see [Window.defaultRouteName]).
///
/// This widget also configures the observer of the top-level [Navigator] (if
/// any) to perform [Hero] animations.
///
/// If [home], [routes], [onGenerateRoute], and [onUnknownRoute] are all null,
/// and [builder] is not null, then no [Navigator] is created.
///
/// {@tool sample}
/// This example shows how to create a [AnimatedThemeApp] that disables the "debug"
/// banner with a [home] route that will be displayed when the app is launched.
///
/// ![The MaterialApp displays a Scaffold ](https://flutter.github.io/assets-for-api-docs/assets/material/basic_material_app.png)
///
/// ```dart
/// MaterialApp(
///   home: Scaffold(
///     appBar: AppBar(
///       title: const Text('Home'),
///     ),
///   ),
///   debugShowCheckedModeBanner: false,
/// )
/// ```
/// {@end-tool}
///
/// {@tool sample}
/// This example shows how to create a [AnimatedThemeApp] that uses the [routes]
/// `Map` to define the "home" route and an "about" route.
///
/// ```dart
/// MaterialApp(
///   routes: <String, WidgetBuilder>{
///     '/': (BuildContext context) {
///       return Scaffold(
///         appBar: AppBar(
///           title: const Text('Home Route'),
///         ),
///       );
///     },
///     '/about': (BuildContext context) {
///       return Scaffold(
///         appBar: AppBar(
///           title: const Text('About Route'),
///         ),
///       );
///      }
///    },
/// )
/// ```
/// {@end-tool}
///
/// {@tool sample}
/// This example shows how to create a [AnimatedThemeApp] that defines a [theme] that
/// will be used for material widgets in the app.
///
/// ![The MaterialApp displays a Scaffold with a dark background and a blue / grey AppBar at the top](https://flutter.github.io/assets-for-api-docs/assets/material/theme_material_app.png)
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     brightness: Brightness.dark,
///     primaryColor: Colors.blueGrey
///   ),
///   home: Scaffold(
///     appBar: AppBar(
///       title: const Text('MaterialApp Theme'),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Scaffold], which provides standard app elements like an [AppBar] and a [Drawer].
///  * [Navigator], which is used to manage the app's stack of pages.
///  * [MaterialPageRoute], which defines an app page that transitions in a material-specific way.
///  * [WidgetsApp], which defines the basic app elements but does not depend on the material library.
///  * The Flutter Internationalization Tutorial,
///    <https://flutter.dev/tutorials/internationalization/>.
class AnimatedThemeApp extends StatefulWidget {
  /// Creates a MaterialApp.
  ///
  /// At least one of [home], [routes], [onGenerateRoute], or [builder] must be
  /// non-null. If only [routes] is given, it must include an entry for the
  /// [Navigator.defaultRouteName] (`/`), since that is the route used when the
  /// application is launched with an intent that specifies an otherwise
  /// unsupported route.
  ///
  /// This class creates an instance of [WidgetsApp].
  ///
  /// The boolean arguments, [routes], and [navigatorObservers], must not be null.
  AnimatedThemeApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.animationType = AnimationType.FADE_ANIMATED_THEME,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.animationDuration = const Duration(milliseconds: 600),
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        super(key: key);

  /// {@macro flutter.widgets.widgetsApp.navigatorKey}
  final GlobalKey<NavigatorState> navigatorKey;

  /// {@macro flutter.widgets.widgetsApp.home}
  final Widget home;

  /// The application's top-level routing table.
  ///
  /// When a named route is pushed with [Navigator.pushNamed], the route name is
  /// looked up in this map. If the name is present, the associated
  /// [WidgetBuilder] is used to construct a [MaterialPageRoute] that performs
  /// an appropriate transition, including [Hero] animations, to the new route.
  ///
  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder> routes;

  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String initialRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateRoute}
  final RouteFactory onGenerateRoute;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.builder}
  ///
  /// Material specific features such as [showDialog] and [showMenu], and widgets
  /// such as [Tooltip], [PopupMenuButton], also require a [Navigator] to properly
  /// function.
  final TransitionBuilder builder;

  /// {@macro flutter.widgets.widgetsApp.title}
  ///
  /// This value is passed unmodified to [WidgetsApp.title].
  final String title;

  /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
  ///
  /// This value is passed unmodified to [WidgetsApp.onGenerateTitle].
  final GenerateAppTitle onGenerateTitle;

  final AnimationType animationType;

  final Duration animationDuration;

  /// Default visual properties, like colors fonts and shapes, for this app's
  /// material widgets.
  ///
  /// A second [darkTheme] [ThemeData] value, which is used to provide a dark
  /// version of the user interface can also be specified. [themeMode] will
  /// control which theme will be used if a [darkTheme] is provided.
  ///
  /// The default value of this property is the value of [ThemeData.light()].
  ///
  /// See also:
  ///
  ///  * [themeMode], which controls which theme to use.
  ///  * [MediaQueryData.platformBrightness], which indicates the platform's
  ///    desired brightness and is used to automatically toggle between [theme]
  ///    and [darkTheme] in [MaterialApp].
  ///  * [ThemeData.brightness], which indicates the [Brightness] of a theme's
  ///    colors.
  final ThemeData theme;

  /// The [ThemeData] to use when a 'dark mode' is requested by the system.
  ///
  /// Some host platforms allow the users to select a system-wide 'dark mode',
  /// or the application may want to offer the user the ability to choose a
  /// dark theme just for this application. This is theme that will be used for
  /// such cases. [themeMode] will control which theme will be used.
  ///
  /// This theme should have a [ThemeData.brightness] set to [Brightness.dark].
  ///
  /// Uses [theme] instead when null. Defaults to the value of
  /// [ThemeData.light()] when both [darkTheme] and [theme] are null.
  ///
  /// See also:
  ///
  ///  * [themeMode], which controls which theme to use.
  ///  * [MediaQueryData.platformBrightness], which indicates the platform's
  ///    desired brightness and is used to automatically toggle between [theme]
  ///    and [darkTheme] in [MaterialApp].
  ///  * [ThemeData.brightness], which is typically set to the value of
  ///    [MediaQueryData.platformBrightness].
  final ThemeData darkTheme;

  /// Determines which theme will be used by the application if both [theme]
  /// and [darkTheme] are provided.
  ///
  /// If set to [ThemeMode.system], the choice of which theme to use will
  /// be based on the user's system preferences. If the [MediaQuery.platformBrightnessOf]
  /// is [Brightness.light], [theme] will be used. If it is [Brightness.dark],
  /// [darkTheme] will be used (unless it is [null], in which case [theme]
  /// will be used.
  ///
  /// If set to [ThemeMode.light] the [theme] will always be used,
  /// regardless of the user's system preference.
  ///
  /// If set to [ThemeMode.dark] the [darkTheme] will be used
  /// regardless of the user's system preference. If [darkTheme] is [null]
  /// then it will fallback to using [theme].
  ///
  /// The default value is [ThemeMode.system].
  ///
  /// See also:
  ///
  ///   * [theme], which is used when a light mode is selected.
  ///   * [darkTheme], which is used when a dark mode is selected.
  ///   * [ThemeData.brightness], which indicates to various parts of the
  ///     system what kind of theme is being used.
  final ThemeMode themeMode;

  /// {@macro flutter.widgets.widgetsApp.color}
  final Color color;

  /// {@macro flutter.widgets.widgetsApp.locale}
  final Locale locale;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  ///
  /// Internationalized apps that require translations for one of the locales
  /// listed in [GlobalMaterialLocalizations] should specify this parameter
  /// and list the [supportedLocales] that the application can handle.
  ///
  /// ```dart
  /// import 'package:flutter_localizations/flutter_localizations.dart';
  /// MaterialApp(
  ///   localizationsDelegates: [
  ///     // ... app-specific localization delegate[s] here
  ///     GlobalMaterialLocalizations.delegate,
  ///     GlobalWidgetsLocalizations.delegate,
  ///   ],
  ///   supportedLocales: [
  ///     const Locale('en', 'US'), // English
  ///     const Locale('he', 'IL'), // Hebrew
  ///     // ... other locales the app supports
  ///   ],
  ///   // ...
  /// )
  /// ```
  ///
  /// ## Adding localizations for a new locale
  ///
  /// The information that follows applies to the unusual case of an app
  /// adding translations for a language not already supported by
  /// [GlobalMaterialLocalizations].
  ///
  /// Delegates that produce [WidgetsLocalizations] and [MaterialLocalizations]
  /// are included automatically. Apps can provide their own versions of these
  /// localizations by creating implementations of
  /// [LocalizationsDelegate<WidgetsLocalizations>] or
  /// [LocalizationsDelegate<MaterialLocalizations>] whose load methods return
  /// custom versions of [WidgetsLocalizations] or [MaterialLocalizations].
  ///
  /// For example: to add support to [MaterialLocalizations] for a
  /// locale it doesn't already support, say `const Locale('foo', 'BR')`,
  /// one could just extend [DefaultMaterialLocalizations]:
  ///
  /// ```dart
  /// class FooLocalizations extends DefaultMaterialLocalizations {
  ///   FooLocalizations(Locale locale) : super(locale);
  ///   @override
  ///   String get okButtonLabel {
  ///     if (locale == const Locale('foo', 'BR'))
  ///       return 'foo';
  ///     return super.okButtonLabel;
  ///   }
  /// }
  ///
  /// ```
  ///
  /// A `FooLocalizationsDelegate` is essentially just a method that constructs
  /// a `FooLocalizations` object. We return a [SynchronousFuture] here because
  /// no asynchronous work takes place upon "loading" the localizations object.
  ///
  /// ```dart
  /// class FooLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  ///   const FooLocalizationsDelegate();
  ///   @override
  ///   Future<FooLocalizations> load(Locale locale) {
  ///     return SynchronousFuture(FooLocalizations(locale));
  ///   }
  ///   @override
  ///   bool shouldReload(FooLocalizationsDelegate old) => false;
  /// }
  /// ```
  ///
  /// Constructing a [AnimatedThemeApp] with a `FooLocalizationsDelegate` overrides
  /// the automatically included delegate for [MaterialLocalizations] because
  /// only the first delegate of each [LocalizationsDelegate.type] is used and
  /// the automatically included delegates are added to the end of the app's
  /// [localizationsDelegates] list.
  ///
  /// ```dart
  /// MaterialApp(
  ///   localizationsDelegates: [
  ///     const FooLocalizationsDelegate(),
  ///   ],
  ///   // ...
  /// )
  /// ```
  /// See also:
  ///
  ///  * [supportedLocales], which must be specified along with
  ///    [localizationsDelegates].
  ///  * [GlobalMaterialLocalizations], a [localizationsDelegates] value
  ///    which provides material localizations for many languages.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleListResolutionCallback localeListResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.localeResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleResolutionCallback localeResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  ///
  /// It is passed along unmodified to the [WidgetsApp] built by this widget.
  ///
  /// See also:
  ///
  ///  * [localizationsDelegates], which must be specified for localized
  ///    applications.
  ///  * [GlobalMaterialLocalizations], a [localizationsDelegates] value
  ///    which provides material localizations for many languages.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<Locale> supportedLocales;

  /// Turns on a performance overlay.
  ///
  /// See also:
  ///
  ///  * <https://flutter.dev/debugging/#performanceoverlay>
  final bool showPerformanceOverlay;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information
  /// reported by the framework.
  final bool showSemanticsDebugger;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// Turns on a [GridPaper] overlay that paints a baseline grid
  /// Material apps.
  ///
  /// Only available in checked mode.
  ///
  /// See also:
  ///
  ///  * <https://material.io/design/layout/spacing-methods.html>
  final bool debugShowMaterialGrid;

  @override
  _AnimatedThemeAppState createState() => _AnimatedThemeAppState();
}

class _MaterialScrollBehavior extends ScrollBehavior {
  @override
  TargetPlatform getPlatform(BuildContext context) {
    return Theme.of(context).platform;
  }

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // When modifying this function, consider modifying the implementation in
    // the base class as well.
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
    }
    return null;
  }
}

class _AnimatedThemeAppState extends State<AnimatedThemeApp> {
  HeroController _heroController;
  GlobalKey<CircularAnimatedThemeState> key = GlobalKey();
  ThemeMode lastThemeMode;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
    _updateNavigator();
  }

  @override
  void didUpdateWidget(AnimatedThemeApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigatorKey != oldWidget.navigatorKey) {
      // If the Navigator changes, we have to create a new observer, because the
      // old Navigator won't be disposed (and thus won't unregister with its
      // observers) until after the new one has been created (because the
      // Navigator has a GlobalKey).
      _heroController = HeroController(createRectTween: _createRectTween);
    }
    _updateNavigator();
  }

  List<NavigatorObserver> _navigatorObservers;

  void _updateNavigator() {
    if (widget.home != null ||
        widget.routes.isNotEmpty ||
        widget.onGenerateRoute != null ||
        widget.onUnknownRoute != null) {
      _navigatorObservers =
          List<NavigatorObserver>.from(widget.navigatorObservers)
            ..add(_heroController);
    } else {
      _navigatorObservers = const <NavigatorObserver>[];
    }
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  // Combine the Localizations for Material with the ones contributed
  // by the localizationsDelegates parameter, if any. Only the first delegate
  // of a particular LocalizationsDelegate.type is loaded so the
  // localizationsDelegate parameter can be used to override
  // _MaterialLocalizationsDelegate.
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (widget.localizationsDelegates != null)
      yield* widget.localizationsDelegates;
    yield DefaultMaterialLocalizations.delegate;
    yield DefaultCupertinoLocalizations.delegate;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = WidgetsApp(
      key: GlobalObjectKey(this),
      navigatorKey: widget.navigatorKey,
      navigatorObservers: _navigatorObservers,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return MaterialPageRoute<T>(settings: settings, builder: builder);
      },
      home: widget.home,
      routes: widget.routes,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      builder: (BuildContext context, Widget child) {
        // Use a light theme, dark theme, or fallback theme.
        final ThemeMode mode = widget.themeMode ?? ThemeMode.system;
        ThemeData theme;
        ThemeData endTheme;

        switch (widget.animationType) {
          case AnimationType.FADE_ANIMATED_THEME:
          case AnimationType.SCALE_ANIMATED_THEME:
            if (widget.darkTheme != null) {
              final ui.Brightness platformBrightness =
                  MediaQuery.platformBrightnessOf(context);
              if (mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      platformBrightness == ui.Brightness.dark)) {
                theme = widget.darkTheme;
              }
            }
            theme ??= widget.theme ?? ThemeData.fallback();
            break;
          case AnimationType.CIRCULAR_ANIMATED_THEME:
            if (widget.darkTheme != null) {
              final ui.Brightness platformBrightness =
                  MediaQuery.platformBrightnessOf(context);
              if (mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      platformBrightness == ui.Brightness.dark)) {
                theme = widget.theme;
              } else
                theme ??= widget.darkTheme ?? ThemeData.fallback();
            } else
              theme ??= widget.darkTheme ?? ThemeData.fallback();

            // Use a light theme, dark theme, or fallback theme.
            if (widget.darkTheme != null) {
              final ui.Brightness platformBrightness =
                  MediaQuery.platformBrightnessOf(context);
              if (mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      platformBrightness == ui.Brightness.dark)) {
                endTheme = widget.darkTheme;
              } else
                endTheme ??= widget.theme ?? ThemeData.fallback();
            } else
              endTheme ??= widget.theme ?? ThemeData.fallback();

//             if (lastThemeMode != mode && key.currentState != null) {
            /// To be able to change theme even in the same dark/light theme mode (for example when we have multiple color schemes for each dark/light theme.
                        if (key.currentState != null) {
              key.currentState.startAnimation();
            }
            lastThemeMode = mode;

            break;
        }

        switch (widget.animationType) {
          case AnimationType.FADE_ANIMATED_THEME:
            return FadeAnimatedTheme(
              duration: widget.animationDuration,
              data: theme,
              isMaterialAppTheme: true,
              child: widget.builder != null
                  ? Builder(
                      builder: (BuildContext context) {
                        // Why are we surrounding a builder with a builder?
                        //
                        // The widget.builder may contain code that invokes
                        // Theme.of(), which should return the theme we selected
                        // above in AnimatedTheme. However, if we invoke
                        // widget.builder() directly as the child of AnimatedTheme
                        // then there is no Context separating them, and the
                        // widget.builder() will not find the theme. Therefore, we
                        // surround widget.builder with yet another builder so that
                        // a context separates them and Theme.of() correctly
                        // resolves to the theme we passed to AnimatedTheme.
                        return widget.builder(context, child);
                      },
                    )
                  : child,
            );
            break;
          case AnimationType.SCALE_ANIMATED_THEME:
            return ScaleAnimatedTheme(
              duration: widget.animationDuration,
              data: theme,
              isMaterialAppTheme: true,
              child: widget.builder != null
                  ? Builder(
                      builder: (BuildContext context) {
                        // Why are we surrounding a builder with a builder?
                        //
                        // The widget.builder may contain code that invokes
                        // Theme.of(), which should return the theme we selected
                        // above in AnimatedTheme. However, if we invoke
                        // widget.builder() directly as the child of AnimatedTheme
                        // then there is no Context separating them, and the
                        // widget.builder() will not find the theme. Therefore, we
                        // surround widget.builder with yet another builder so that
                        // a context separates them and Theme.of() correctly
                        // resolves to the theme we passed to AnimatedTheme.
                        return widget.builder(context, child);
                      },
                    )
                  : child,
            );
            break;
          case AnimationType.CIRCULAR_ANIMATED_THEME:
            return CircularAnimatedTheme(
              key: key,
              data: theme,
              end: endTheme,
              isMaterialAppTheme: true,
              curve: Curves.ease,
              duration: widget.animationDuration,
              child: widget.builder != null
                  ? Builder(
                      builder: (BuildContext context) {
                        // Why are we surrounding a builder with a builder?
                        //
                        // The widget.builder may contain code that invokes
                        // Theme.of(), which should return the theme we selected
                        // above in AnimatedTheme. However, if we invoke
                        // widget.builder() directly as the child of AnimatedTheme
                        // then there is no Context separating them, and the
                        // widget.builder() will not find the theme. Therefore, we
                        // surround widget.builder with yet another builder so that
                        // a context separates them and Theme.of() correctly
                        // resolves to the theme we passed to AnimatedTheme.
                        return widget.builder(context, child);
                      },
                    )
                  : child,
            );
            break;
          default:
            throw Exception('Animation type error');
            break;
        }
      },
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      textStyle: _errorTextStyle,
      // The color property is always pulled from the light theme, even if dark
      // mode is activated. This was done to simplify the technical details
      // of switching themes and it was deemed acceptable because this color
      // property is only used on old Android OSes to color the app bar in
      // Android's switcher UI.
      //
      // blue is the primary color of the default theme
      color: widget.color ?? widget.theme?.primaryColor ?? Colors.blue,
      locale: widget.locale,
      localizationsDelegates: _localizationsDelegates,
      localeResolutionCallback: widget.localeResolutionCallback,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      supportedLocales: widget.supportedLocales,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      inspectorSelectButtonBuilder:
          (BuildContext context, VoidCallback onPressed) {
        return FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: onPressed,
          mini: true,
        );
      },
    );

    assert(() {
      if (widget.debugShowMaterialGrid) {
        result = GridPaper(
          color: const Color(0xE0F9BBE0),
          interval: 8.0,
          divisions: 2,
          subdivisions: 1,
          child: result,
        );
      }
      return true;
    }());

    return ScrollConfiguration(
      behavior: _MaterialScrollBehavior(),
      child: result,
    );
  }
}
