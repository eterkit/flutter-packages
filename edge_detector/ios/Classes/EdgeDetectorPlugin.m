#import "EdgeDetectorPlugin.h"
#if __has_include(<edge_detector/edge_detector-Swift.h>)
#import <edge_detector/edge_detector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "edge_detector-Swift.h"
#endif

@implementation EdgeDetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEdgeDetectorPlugin registerWithRegistrar:registrar];
}
@end
