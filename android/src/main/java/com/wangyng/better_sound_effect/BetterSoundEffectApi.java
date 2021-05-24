package com.wangyng.better_sound_effect;

import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;

import java.io.File;
import java.io.FileDescriptor;
import java.util.HashMap;
import java.util.Map;

import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;

public interface BetterSoundEffectApi {

    // 加载音频文件
    int loadAudioFile(AssetFileDescriptor fileDescriptor);

    // 加载音频文件
    int loadAudioFile(String path);

    // 播放音效
    void play(int soundId);

    // 释放音效资源
    void release(int soundId);

    static void setup(BinaryMessenger binaryMessenger, BetterSoundEffectApi api, Context context) {
        { // initSDK
            BasicMessageChannel<Object> channel = new BasicMessageChannel<>(binaryMessenger, "com.wangyng.better_sound_effect.loadAudioFile", new StandardMessageCodec());
            if (api != null) {
                channel.setMessageHandler((message, reply) -> {
                    Map<String, HashMap<String, Object>> wrapped = new HashMap<>();
                    int soundId = 0;
                    try {
                        HashMap<String, Object> params = (HashMap<String, Object>) message;
                        if (params != null && params.containsKey("asset")) {
                            String asset = (String) params.get("asset");
                            FlutterLoader loader = FlutterInjector.instance().flutterLoader();
                            String filename = loader.getLookupKeyForAsset(asset);
                            AssetFileDescriptor fileDescriptor = context.getAssets().openFd(filename);
                            soundId = api.loadAudioFile(fileDescriptor);
                        } else if (params != null && params.containsKey("file")) {
                            String path = (String) params.get("file");
                            soundId = api.loadAudioFile(path);
                        }

                        HashMap<String, Object> result = new HashMap<>();
                        result.put("soundId", soundId);

                        wrapped.put("result", result);
                    } catch (Exception exception) {
                        wrapped.put("error", wrapError(exception));
                    }
                    reply.reply(wrapped);
                });
            } else {
                channel.setMessageHandler(null);
            }
        }
        { // play
            BasicMessageChannel<Object> channel = new BasicMessageChannel<>(binaryMessenger, "com.wangyng.better_sound_effect.play", new StandardMessageCodec());
            if (api != null) {
                channel.setMessageHandler((message, reply) -> {
                    Map<String, HashMap<String, Object>> wrapped = new HashMap<>();
                    try {
                        HashMap<String, Object> params = (HashMap<String, Object>) message;
                        if (params != null && params.containsKey("soundId")) {
                            int soundId = (int) params.get("soundId");
                            api.play(soundId);
                        }

                        wrapped.put("result", null);
                    } catch (Exception exception) {
                        wrapped.put("error", wrapError(exception));
                    }
                    reply.reply(wrapped);
                });
            } else {
                channel.setMessageHandler(null);
            }
        }
        { // release
            BasicMessageChannel<Object> channel = new BasicMessageChannel<>(binaryMessenger, "com.wangyng.better_sound_effect.release", new StandardMessageCodec());
            if (api != null) {
                channel.setMessageHandler((message, reply) -> {
                    Map<String, HashMap<String, Object>> wrapped = new HashMap<>();
                    try {
                        HashMap<String, Object> params = (HashMap<String, Object>) message;
                        if (params != null && params.containsKey("soundId")) {
                            int soundId = (int) params.get("soundId");
                            api.release(soundId);
                        }

                        wrapped.put("result", null);
                    } catch (Exception exception) {
                        wrapped.put("error", wrapError(exception));
                    }
                    reply.reply(wrapped);
                });
            } else {
                channel.setMessageHandler(null);
            }
        }
    }

    static HashMap<String, Object> wrapError(Exception exception) {
        HashMap<String, Object> errorMap = new HashMap<>();
        errorMap.put("message", exception.toString());
        errorMap.put("code", null);
        errorMap.put("details", null);
        return errorMap;
    }
}
