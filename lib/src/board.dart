import 'dart:html';
import './emoji.dart';
import './grid.dart';
import './game.dart';

class MemoryGameBoard {
  MemoryGameBoard(this.stage);

  static final int numberOfTiles = 16;
  String stage;
  final Set emojis = new EmojiService().getCollection(numberOfTiles);
  List<Map> _tiles;
  MemoryGameState _state;

  set state(val) {
    _state = val;
    createTileMap();
  }

  void createTileMap() {
    var emojiList = emojis.toList();
    emojiList.addAll(new List.from(emojiList));
    List<Map<String, dynamic>> tiles = [];
    var i = 0;
    var isBeforeStart = _state == MemoryGameState.beforeStart;

    // Couple a' shuffles :D
    emojiList.shuffle();
    emojiList.shuffle();
    emojiList.shuffle();

    while (i < numberOfTiles) {
      tiles.add({
        "id": i,
        "emoji": isBeforeStart ? null : emojiList[i],
        "onClick": isBeforeStart
            ? null
            : (id) {
                print(tiles.singleWhere((tile) => tile["id"] == id));
                updateTileMap(id);
              },
        "isVisible": false,
        "disabled": isBeforeStart
      });
      i++;
    }
    this._tiles = tiles;
  }

  void updateTileMap(int id) {
    List<Map> tilesCopy = List.from(_tiles);
    var updatedTile = tilesCopy.singleWhere((tile) => tile["id"] == id,
        orElse: () => null)
      ..update("isVisible", (val) => true);

    tilesCopy[id] = updatedTile;
    _tiles = tilesCopy.toList();

    render();
  }

  void render() {
    querySelector(stage)
      ..innerHtml = ''
      ..append(
          new Grid(wrapperClass: 'memory-game-grid', tiles: _tiles).generate());
  }
}
