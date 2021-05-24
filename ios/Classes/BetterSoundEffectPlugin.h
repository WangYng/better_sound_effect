#import <Flutter/Flutter.h>
#import "BetterSoundEffectApi.h"

@interface BetterSoundEffectPlugin : NSObject<BetterSoundEffectApiDelegate>

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;

@end
