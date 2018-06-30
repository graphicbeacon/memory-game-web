import 'dart:html';
import './tile.dart';
import './emoji.dart';

class Grid {
  static const int numberOfTiles = 16;
  final Set emojis;
  final String wrapperClass;
  bool disabled;
  List<Map> tiles = [];

  Grid({this.wrapperClass, this.disabled})
      : emojis = new EmojiService().getCollection(numberOfTiles) {
    createTileMap();
  }

  void createTileMap() {
    var emojiList = emojis.toList();
    emojiList.addAll(new List.from(emojiList));
    var i = 0;

    // Couple a' shuffles :D
    emojiList.shuffle();
    emojiList.shuffle();
    emojiList.shuffle();

    while (i < numberOfTiles) {
      tiles.add({
        "emoji": emojiList[i],
        "onShow": (emoji) => print('shown $emoji'),
        "onHide": () => print('hide'),
        "disabled": disabled
      });
      i++;
    }
  }

  DocumentFragment generate() {
    var gridFragment = new DocumentFragment();
    gridFragment.append(new DivElement()..className = this.wrapperClass);

    for (var ii = 0; ii < numberOfTiles; ii++) {
      gridFragment.firstChild.append(Tile.fromMap(tiles[ii]).generate());
    }

    return gridFragment;
  }
}
