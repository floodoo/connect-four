const Set<Song> songs = {
  Song('road-in-the-forest-115035.mp3', 'Road in the forest', artist: 'Olexy'),
  Song(
    'in-the-forest-ambient-acoustic-guitar-instrumental-background-music-for-videos-5718.mp3',
    'In the Forest - Ambient Acoustic Guitar Instrumental Background Music For Videos',
    artist: 'Oleksii Kaplunskyi',
  ),
  Song('road-in-the-forest-115035.mp3', 'My Life (Main)', artist: 'Zakhar Valaha'),
};

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
