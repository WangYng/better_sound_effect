//
//  BetterSoundEffectApi.h
//  better_sound_effect
//
//  Created by 汪洋 on 2021/5/24.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@protocol BetterSoundEffectApiDelegate <NSObject>

// 加载音频文件
- (NSInteger)loadAudioFile:(NSString *)path;

// 播放音效
- (void)play:(NSInteger)soundId;

// 释放音效资源
- (void)release:(NSInteger)soundId;

@end

@interface BetterSoundEffectApi : NSObject

+ (void)setup:(NSObject<FlutterPluginRegistrar>*)registrar api:(id<BetterSoundEffectApiDelegate>)api;

@end

