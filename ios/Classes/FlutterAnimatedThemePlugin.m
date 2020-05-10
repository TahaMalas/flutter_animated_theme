#import "FlutterAnimatedThemePlugin.h"
#if __has_include(<flutter_animated_theme/flutter_animated_theme-Swift.h>)
#import <flutter_animated_theme/flutter_animated_theme-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_animated_theme-Swift.h"
#endif

@implementation FlutterAnimatedThemePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAnimatedThemePlugin registerWithRegistrar:registrar];
}
@end
