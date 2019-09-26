#import "TimePickerPlugin.h"
#import <time_picker/time_picker-Swift.h>

@implementation TimePickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTimePickerPlugin registerWithRegistrar:registrar];
}
@end
