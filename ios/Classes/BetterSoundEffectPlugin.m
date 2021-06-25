#import "BetterSoundEffectPlugin.h"
#import <AVFoundation/AVFoundation.h>

@interface BetterSoundEffectPlugin ()

@property (nonatomic, strong) NSMutableArray *soundPool;

@end

@implementation BetterSoundEffectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    BetterSoundEffectPlugin* instance = [[BetterSoundEffectPlugin alloc] init];
    [BetterSoundEffectApi setup:registrar api:instance];
}
- (NSInteger)loadAudioFile:(NSString *)path {
    if (!self.soundPool) {
        self.soundPool = [NSMutableArray new];
    }
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [player prepareToPlay];
    
    [self.soundPool addObject:player];
    
    return [self.soundPool indexOfObject:player];
}

- (void)play:(NSInteger)soundId {
    NSObject *player = [self.soundPool objectAtIndex:soundId];
    if ([player isKindOfClass:AVAudioPlayer.class]) {
        AVAudioPlayer *audioPlayer = ((AVAudioPlayer *)player);
        if (audioPlayer.isPlaying) {
            [audioPlayer pause];
        }
        audioPlayer.currentTime = 0;
        [audioPlayer play];
    }
}

- (void)release:(NSInteger)soundId {
    NSObject *player = [self.soundPool objectAtIndex:soundId];
    if ([player isKindOfClass:AVAudioPlayer.class]) {
        [((AVAudioPlayer *)player) stop];
    }
    [self.soundPool replaceObjectAtIndex:soundId withObject:[NSObject new]];
}

@end
