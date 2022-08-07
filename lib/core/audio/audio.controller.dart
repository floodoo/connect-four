import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:connect_four/core/audio/songs.dart';
import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  final _musicPlayer = AudioPlayer(playerId: 'musicPlayer');
  final _playlist = Queue.of(List<Song>.of(songs)..shuffle());

  Future<void> playMusic() async {
    final song = _playlist.removeFirst();
    await _musicPlayer.setSource(AssetSource("/music/${song.filename}"));
    _playlist.add(song);
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
