import 'dart:html';

class Tile {
  Tile(this.emoji);

  final String emoji;

  ButtonElement generate() {
    return new ButtonElement()..text = emoji;
  }
}
