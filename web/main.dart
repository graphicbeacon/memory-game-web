import 'dart:html';

void main() {
  new MemoryGame('#output').start();
}

// Game
class MemoryGame {
  MemoryGame(this.stage);

  final String stage;

  void _generate() {
    querySelector(stage)
      ..firstChild.remove()
      ..append(new Grid(9)._generate());
  }

  void start() {
    _generate();
  }
  // Track score
}

class EmojiFactory {
  List<String> emojis = [''];

  List<String> _generate() {}
}

// Grid
class Grid {
  Grid(this.numberOfTiles);

  final int numberOfTiles;
  final Set emojiList;

  DocumentFragment _generate() {
    var tileFragment = document.createDocumentFragment();
    tileFragment.append(new DivElement());

    for (var ii = 0; ii < numberOfTiles; ii++) {
      tileFragment.firstChild.append(new Tile(ii.toString())._generate());
    }
    return tileFragment;
  }
}

// Tile
class Tile {
  Tile(this.emoji);

  final String emoji;

  ButtonElement _generate() {
    return new ButtonElement()..text = emoji;
  }
}
