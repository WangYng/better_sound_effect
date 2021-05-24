#import "BetterSoundEffectPlugin.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation BetterSoundEffectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    BetterSoundEffectPlugin* instance = [[BetterSoundEffectPlugin alloc] init];
    [BetterSoundEffectApi setup:registrar api:instance];
}
- (NSInteger)loadAudioFile:(NSString *)path {
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:path], &soundId);
    return soundId;
}

- (void)play:(NSInteger)soundId {
    AudioServicesPlaySystemSound((SystemSoundID)soundId);
}

- (void)release:(NSInteger)soundId {
    AudioServicesDisposeSystemSoundID((SystemSoundID)soundId);
}

@end
