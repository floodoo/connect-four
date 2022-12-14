import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:connect_four/core/audio/songs.dart';
import 'package:connect_four/utils/logger.util.dart';
import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  final _log = LoggerUtil(name: 'audio.controller.dart').logger;
  final _musicPlayer = AudioPlayer(playerId: 'musicPlayer');
  final _playlist = Queue.of(List<Song>.of(songs)..shuffle());

  Future<void> playMusic() async {
    final song = _playlist.removeFirst();
    _log.info('Playing music $song');

    await _musicPlayer.setSource(AssetSource("/music/${song.filename}"));
    _playlist.add(song);

    _musicPlayer.onPlayerComplete.listen((event) {
      _log.info('Song finished');
      _musicPlayer.stop();
      playMusic();
    });
  }

  void pauseMusic() {
    _musicPlayer.pause();
  }

  void resumeMusic() {
    _musicPlayer.resume();
  }

  void stopMusic() {
    _musicPlayer.stop();
  }
}
