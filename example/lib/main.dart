import 'dart:async';

import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final soundEffect = BetterSoundEffect();

  int? soundId;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      soundId = await soundEffect.loadAssetAudioFile("assets/button.wav");
    });
  }

  @override
  void dispose() {
    if (soundId != null) {
      soundEffect.release(soundId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: CupertinoButton(
            child: Text("click"),
            onPressed: () {
              if (soundId != null) {
                soundEffect.play(soundId!);
              }
            },
          ),
        ),
      ),
    );
  }
}
