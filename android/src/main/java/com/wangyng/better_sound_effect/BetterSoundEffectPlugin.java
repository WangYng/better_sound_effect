package com.wangyng.better_sound_effect;

import android.content.res.AssetFileDescriptor;

import androidx.annotation.NonNull;

import java.io.File;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * BetterSoundEffectPlugin
 */
public class BetterSoundEffectPlugin implements FlutterPlugin, BetterSoundEffectApi {

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        BetterSoundEffectApi.setup(binding.getBinaryMessenger(), this, binding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        BetterSoundEffectApi.setup(binding.getBinaryMessenger(), null, null);
    }

    @Override
    public int loadAudioFile(AssetFileDescriptor fileDescriptor) {
        return WrappedSoundPool.load(fileDescriptor);
    }

    @Override
    public int loadAudioFile(String path) {
        return WrappedSoundPool.load(path);
    }

    @Override
    public void play(int soundId) {
        WrappedSoundPool.play(soundId);
    }

    @Override
    public void release(int soundId) {
        WrappedSoundPool.release(soundId);
    }
}
