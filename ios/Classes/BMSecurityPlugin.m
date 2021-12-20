#import "BMSecurityPlugin.h"
#if __has_include(<bm_security_plugin/bm_security_plugin-Swift.h>)
#import <bm_security_plugin/bm_security_plugin-Swift.h>
#else
#import "bm_security_plugin-Swift.h"
#endif

@implementation BMSecurityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBMSecurityPlugin registerWithRegistrar:registrar];
}
@end
