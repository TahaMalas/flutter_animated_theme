# flutter_animated_theme

Customize animation on theme changing in Flutter, the idea was inspired by the Telegram theme changing animation, I researched for it and did not find anything similar in Flutter, so that how this package spotted the light

## Getting Started

### Add dependency

```yaml
dependencies:
  flutter_animated_theme: ^0.5.0
```

## Available animations


Trust me the animation is smoother than it's looking, they are laggy in the demonstration below because it's a GIF.

AnimationType | FADE_ANIMATED_THEME(default) | SCALE_ANIMATED_THEME | CIRCULAR_ANIMATED_THEME
--- | --- | --- | ---
Result | ![](https://media.giphy.com/media/QZDvnOBXsn1qVE8H4B/source.gif) | ![](https://media.giphy.com/media/Z9EMsThcQfIQMllXtO/source.gif) | ![](https://media.giphy.com/media/JUjhwnGGU81S2c8vO9/source.gif)



## How to use it

We'll start by declaring our light and dark themes first

```
final lightTheme = ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.greenAccent,
        bottomAppBarColor: Colors.greenAccent,
        hintColor: Colors.yellowAccent,
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
        ),
      );
```

```
final darkTheme = ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.blueAccent,
        hintColor: Colors.deepOrangeAccent,
        bottomAppBarColor: Colors.grey,
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
        ),
      );
```

Now import the package files

```
import 'package:flutter_animated_theme/animated_theme_app.dart';
import 'package:flutter_animated_theme/animation_type.dart';
```

Then you will have to use a custom application that is inside the package, it only adds the animation feature to your app, so you'll still be getting all the features that a normal MaterialApp uses, in your build function for the app class add this.

```
return AnimatedThemeApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: //Your home page,
    );
```

Now you will be getting the default animation which is Fade in that comes right off the bat from Flutter, with a default animation duration of 600 milliseconds.

You can customize it like this.

```
return AnimatedThemeApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      animationDuration: Duration(milliseconds: 500),
      animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: //Your home page,
    );

```

You can change the animation type to one of the currently implemented animations.

```
enum AnimationType {
  FADE_ANIMATED_THEME,
  SCALE_ANIMATED_THEME,
  CIRCULAR_ANIMATED_THEME,
}
```

Also change the animation duration to fit your needs.


## Where we are going with this

We are trying to implement more animations to enhance the package even more, so please don't hesitate to let us know the ideas you have in mind so that we can work on making it available for the public.