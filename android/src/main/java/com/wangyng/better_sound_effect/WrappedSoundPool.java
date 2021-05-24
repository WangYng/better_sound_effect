package com.wangyng.better_sound_effect;

import android.content.res.AssetFileDescriptor;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.SoundPool;
import android.os.Build;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class WrappedSoundPool {

    private static final SoundPool soundPool = createSoundPool();

    private static SoundPool createSoundPool() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            AudioAttributes attrs = new AudioAttributes.Builder().setLegacyStreamType(AudioManager.USE_DEFAULT_STREAM_TYPE)
                    .setUsage(AudioAttributes.USAGE_GAME)
                    .build();
            return new SoundPool.Builder()
                    .setAudioAttributes(attrs)
                    .setMaxStreams(100)
                    .build();
        } else {
            //noinspection deprecation
            return new SoundPool(1, AudioManager.STREAM_MUSIC, 1);
        }
    }

    static int load(final String path) {
        return soundPool.load(path, 1);
    }

    static int load(final AssetFileDescriptor fileDescriptor) {
        return soundPool.load(fileDescriptor, 1);
    }

    static void play(int soundId) {
        soundPool.play(soundId, 1, 1, 0, 0, 1.0f);
    }

    static void release(int soundId) {
        soundPool.unload(soundId);
    }
}
