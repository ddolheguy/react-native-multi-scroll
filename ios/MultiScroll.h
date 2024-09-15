
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNMultiScrollSpec.h"

@interface MultiScroll : NSObject <NativeMultiScrollSpec>
#else
#import <React/RCTBridgeModule.h>

@interface MultiScroll : NSObject <RCTBridgeModule>
#endif

@end
