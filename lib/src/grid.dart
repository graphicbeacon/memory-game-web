import 'dart:html';
import './tile.dart';
import './emoji.dart';

class Grid {
  static const int numberOfTiles = 16;
  final Set emojis;

  Grid() : emojis = new EmojiService().getCollection(numberOfTiles);

  List buildTiles() {
    var emojiList = emojis.toList();
    emojiList.addAll(new List.from(emojiList));
    var tiles = [];
    var i = 0;

    // Couple a' shuffles :D
    emojiList.shuffle();
    emojiList.shuffle();
    emojiList.shuffle();

    while (i < numberOfTiles) {
      tiles.add(new Tile(
          emoji: emojiList[i],
          onShow: (emoji) => print('shown $emoji'),
          onHide: () => print('hide')).generate());
      i++;
    }

    return tiles;
  }

  DocumentFragment generate() {
    var gridFragment = document.createDocumentFragment();
    var tiles = buildTiles();
    gridFragment.append(new DivElement());

    for (var ii = 0; ii < numberOfTiles; ii++) {
      gridFragment.firstChild.append(tiles[ii]);
    }

    return gridFragment;
  }
}
