#import "MobileCoinFlutterPlugin.h"
#if __has_include(<mobilecoin_flutter/mobilecoin_flutter-Swift.h>)
#import <mobilecoin_flutter/mobilecoin_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mobilecoin_flutter-Swift.h"
#endif

@implementation MobileCoinFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMobileCoinPlugin registerWithRegistrar:registrar];
}
@end
