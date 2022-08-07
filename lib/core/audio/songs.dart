const Set<Song> songs = {
  Song('road-in-the-forest-115035.mp3', 'Road in the forest', artist: 'Olexy'),
};

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
