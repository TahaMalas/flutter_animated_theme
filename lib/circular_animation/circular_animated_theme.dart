import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animated_theme/circular_animation/capture_widget.dart';
import 'package:flutter_animated_theme/circular_animation/circular_reveal_clipper.dart';
import 'package:rect_getter/rect_getter.dart';

/// Animated version of [Theme] which automatically transitions the colors,
/// etc, over a given duration whenever the given theme changes.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.elasticInOut].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_theme.mp4}
///
/// See also:
///
///  * [Theme], which [CircularAnimatedTheme] uses to actually apply the interpolated
///    theme.
///  * [ThemeData], which describes the actual configuration of a theme.
///  * [MaterialApp], which includes an [CircularAnimatedTheme] widget configured via
///    the [MaterialApp.theme] argument.
class CircularAnimatedTheme extends StatefulWidget {
  /// Creates an animated theme.
  ///
  /// By default, the theme transition uses a linear curve. The [data] and
  /// [child] arguments must not be null.
  const CircularAnimatedTheme({
    Key key,
    @required this.data,
    @required this.end,
    this.isMaterialAppTheme = false,
    Curve curve = Curves.linear,
    this.duration = kThemeAnimationDuration,
    VoidCallback onEnd,
    @required this.child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key);

  /// Specifies the color and typography values for descendant widgets.
  final ThemeData data;
  final ThemeData end;

  /// True if this theme was created by the [MaterialApp]. See [Theme.isMaterialAppTheme].
  final bool isMaterialAppTheme;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;
  final Duration duration;

  @override
  CircularAnimatedThemeState createState() => CircularAnimatedThemeState();
}

class CircularAnimatedThemeState extends State<CircularAnimatedTheme>
    with SingleTickerProviderStateMixin {
  ThemeDataTween _data;

  Duration animationDuration;
  AnimationController animationController;
  Animation animation;
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  CaptureResult _image;
  final _captureKey = GlobalKey<CaptureWidgetState>();

  void startAnimation() {
    _takeScreenShot();
  }

  void changeData() {
    _data = ThemeDataTween(begin: widget.data, end: widget.end);
  }

  @override
  void initState() {
    super.initState();
    _data = ThemeDataTween(begin: widget.data, end: widget.end);
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    animation = animationController.view;
    animationDuration = widget.duration;

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CaptureWidget(
          key: _captureKey,
          child: IndexedStack(
            index: (animation.value == 0 || animation.value == 1) &&
                animationController.status != AnimationStatus.forward
                ? 0
                : 1,
            children: <Widget>[
              Visibility(
                maintainState: true,
                child: Theme(
                  isMaterialAppTheme: widget.isMaterialAppTheme,
                  child: widget.child,
                  data: _data.end,
                ),
              ),
              _image != null
                  ? SizedBox.expand(
                child: Image.memory(
                  _image.data,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              )
                  : Container(),
            ],
          )
        ),
        RectGetter(
          key: rectGetterKey,
          child: Container(
            alignment: Alignment.topLeft,
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
        _ripple(),
      ],
    );
  }

  _takeScreenShot() {
    _captureKey.currentState.captureImage((image) {
      precacheImage(MemoryImage(image.data), context).then((cachedImage) {
        setState(() {
          _image = image;
        });
        _onChangeTheme();
        animationController.reset();
        animationController.forward();
        setState(() {
          changeData();
        });
      });
    });
  }

  void _onChangeTheme() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
    });
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return ClipPath(
          clipper: CircularRevealClipper(
            fraction: animation.value,
            centerOffset: Offset(0, 0),
          ),
          child: animation.value > 0 && animation.value < 1
              ? Theme(
                  isMaterialAppTheme: widget.isMaterialAppTheme,
                  child: child,
                  data: _data.end,
                )
              : Container(),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<ThemeDataTween>('data', _data,
        showName: false, defaultValue: null));
  }
}
