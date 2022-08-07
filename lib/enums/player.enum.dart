enum Player {
  player1,
  player2,
}

extension PlayerExtension on Player {
  String get name {
    switch (this) {
      case Player.player1:
        return 'Player 1';
      case Player.player2:
        return 'Player 2';
    }
  }
}