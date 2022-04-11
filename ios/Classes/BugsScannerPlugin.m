#import "BugsScannerPlugin.h"
#if __has_include(<bugs_scanner/bugs_scanner-Swift.h>)
#import <bugs_scanner/bugs_scanner-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bugs_scanner-Swift.h"
#endif

@implementation BugsScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBugsScannerPlugin registerWithRegistrar:registrar];
}
@end
