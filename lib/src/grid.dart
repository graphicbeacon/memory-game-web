import 'dart:html';
import './tile.dart';
import './emoji.dart';

class Grid {
  final int numberOfTiles = 16;
  List emojis = new EmojiStore().emojis;

  DocumentFragment generate() {
    var gridFragment = document.createDocumentFragment();
    gridFragment.append(new DivElement());

    for (var ii = 0; ii < numberOfTiles; ii++) {
      gridFragment.firstChild.append(new Tile(emojis[ii]).generate());
    }
    return gridFragment;
  }
}
