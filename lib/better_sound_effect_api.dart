import 'dart:collection';

import 'package:flutter/services.dart';

class BetterSoundEffectApi {
  Future<int?> loadAssetAudioFile(String asset) async {
    const channel =
        BasicMessageChannel<dynamic>('com.wangyng.better_sound_effect.loadAudioFile', StandardMessageCodec());
    final Map<String, dynamic> requestMap = {"asset": asset};
    final reply = await channel.send(requestMap);

    if (!(reply is Map)) {
      _throwChannelException();
    }

    Map<String, dynamic> replyMap = Map<String, dynamic>.from(reply);
    if (replyMap['error'] != null) {
      final HashMap<String, dynamic> error = HashMap.from(replyMap['error']);
      _throwException(error);
    } else {
      final result = replyMap["result"];
      final soundId = result["soundId"];
      return soundId is String ? int.parse(soundId) : soundId.toInt();
    }
  }

  Future<int?> loadAudioFile(String path) async {
    const channel =
        BasicMessageChannel<dynamic>('com.wangyng.better_sound_effect.loadAudioFile', StandardMessageCodec());
    final Map<String, dynamic> requestMap = {"path": path};
    final reply = await channel.send(requestMap);

    if (!(reply is Map)) {
      _throwChannelException();
    }

    Map<String, dynamic> replyMap = Map<String, dynamic>.from(reply);
    if (replyMap['error'] != null) {
      final HashMap<String, dynamic> error = replyMap['error'];
      _throwException(error);
    } else {
      final result = replyMap["result"];
      final soundId = result["soundId"];
      return soundId is String ? int.parse(soundId) : soundId.toInt();
    }
  }

  Future<void> play(int soundId) async {
    const channel = BasicMessageChannel<dynamic>('com.wangyng.better_sound_effect.play', StandardMessageCodec());
    final Map<String, dynamic> requestMap = {"soundId": soundId};
    final reply = await channel.send(requestMap);

    if (!(reply is Map)) {
      _throwChannelException();
    }

    Map<String, dynamic> replyMap = Map<String, dynamic>.from(reply);
    if (replyMap['error'] != null) {
      final HashMap<String, dynamic> error = replyMap['error'];
      _throwException(error);
    } else {
      // noop
    }
  }

  Future<void> release(int soundId) async {
    const channel = BasicMessageChannel<dynamic>('com.wangyng.better_sound_effect.release', StandardMessageCodec());
    final Map<String, dynamic> requestMap = {"soundId": soundId};
    final reply = await channel.send(requestMap);

    if (!(reply is Map)) {
      _throwChannelException();
    }

    Map<String, dynamic> replyMap = Map<String, dynamic>.from(reply);
    if (replyMap['error'] != null) {
      final HashMap<String, dynamic> error = replyMap['error'];
      _throwException(error);
    } else {
      // noop
    }
  }
}

_throwChannelException() {
  throw PlatformException(code: 'channel-error', message: 'Unable to establish connection on channel.', details: null);
}

_throwException(HashMap<String, dynamic> error) {
  throw PlatformException(code: "${error['code']}", message: "${error['message']}", details: "${error['details']}");
}
