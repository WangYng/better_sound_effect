//
//  BetterSoundEffectApi.m
//  better_sound_effect
//
//  Created by 汪洋 on 2021/5/24.
//

#import "BetterSoundEffectApi.h"

@implementation BetterSoundEffectApi

+ (void)setup:(NSObject<FlutterPluginRegistrar>*)registrar api:(id<BetterSoundEffectApiDelegate>)api {
    
    {
        FlutterBasicMessageChannel *channel =[FlutterBasicMessageChannel messageChannelWithName:@"com.wangyng.better_sound_effect.loadAudioFile" binaryMessenger:[registrar messenger]];
        
        if (api != nil) {
            [channel setMessageHandler:^(id  message, FlutterReply reply) {
                
                NSInteger soundId = 0;
                
                NSMutableDictionary<NSString *, NSObject *> *wrapped = [NSMutableDictionary new];
                if ([message isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *params = message;
                    if (params[@"path"]) {
                        NSString *path = params[@"path"];
                        
                        soundId = [api loadAudioFile:path];
                        
                    } else if (params[@"asset"]) {
                        NSString* key = [registrar lookupKeyForAsset:params[@"asset"]];
                        NSString* path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
                        
                        soundId = [api loadAudioFile:path];
                    }
                    
                    wrapped[@"result"] = @{@"soundId": @(soundId)};
                } else {
                    wrapped[@"error"] = @{@"message": @"parse message error"};
                }
                reply(wrapped);
            }];
        } else {
            [channel setMessageHandler:nil];
        }
    }
    
    {
        FlutterBasicMessageChannel *channel =[FlutterBasicMessageChannel messageChannelWithName:@"com.wangyng.better_sound_effect.play" binaryMessenger:[registrar messenger]];
        
        if (api != nil) {
            [channel setMessageHandler:^(id  message, FlutterReply reply) {
                
                NSMutableDictionary<NSString *, NSObject *> *wrapped = [NSMutableDictionary new];
                if ([message isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary<NSString *, id> *params = message;
                    NSInteger soundId = [params[@"soundId"] intValue];
                    
                    [api play:soundId];
                    
                    wrapped[@"result"] = nil;
                } else {
                    wrapped[@"error"] = @{@"message": @"parse message error"};
                }
                reply(wrapped);
            }];
        } else {
            [channel setMessageHandler:nil];
        }
    }
    
    {
        FlutterBasicMessageChannel *channel =[FlutterBasicMessageChannel messageChannelWithName:@"com.wangyng.better_sound_effect.release" binaryMessenger:[registrar messenger]];
        
        if (api != nil) {
            [channel setMessageHandler:^(id  message, FlutterReply reply) {
                
                NSMutableDictionary<NSString *, NSObject *> *wrapped = [NSMutableDictionary new];
                if ([message isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary<NSString *, id> *params = message;
                    NSInteger soundId = (NSInteger)params[@"soundId"];
                    [api play:soundId];
                    
                    wrapped[@"result"] = nil;
                } else {
                    wrapped[@"error"] = @{@"message": @"parse message error"};
                }
                reply(wrapped);
            }];
        } else {
            [channel setMessageHandler:nil];
        }
    }
}

@end
