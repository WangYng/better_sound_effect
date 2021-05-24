import 'dart:async';

import 'package:better_sound_effect/better_sound_effect_api.dart';
import 'package:flutter/services.dart';

class BetterSoundEffect {

  final _api = BetterSoundEffectApi();

  Future<int?> loadAssetAudioFile(String asset) async {
    return _api.loadAssetAudioFile(asset);
  }

  Future<int?> loadAudioFile(String path) async {
    return _api.loadAudioFile(path);
  }

  Future<void> play(int soundId) async {
    _api.play(soundId);
  }

  Future<void> release(int soundId) async {
    _api.release(soundId);
  }
}
