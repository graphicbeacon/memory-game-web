import 'dart:html';
import 'dart:async';

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

  int tileRevealCount = 0;
  List<Map> revealedTiles = [];

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
    if (!isBeforeStart) {
      emojiList.shuffle();
      emojiList.shuffle();
      emojiList.shuffle();
    }

    while (i < numberOfTiles) {
      tiles.add({
        "id": i,
        "emoji": isBeforeStart ? null : emojiList[i],
        "onClick": isBeforeStart ? null : openTileCallback,
        "isVisible": false,
        "disabled": isBeforeStart
      });
      i++;
    }
    this._tiles = tiles;
  }

  void openTileCallback(int id) {
    if (tileRevealCount == numberOfTiles) return;

    if (revealedTiles.length < 2) {
      revealedTiles.add(_tiles[id]);
      updateTileMap(id);
      render();
    }

    if (revealedTiles.length == 2) {
      var hasMatchingPair =
          revealedTiles[0]["emoji"] == revealedTiles[1]["emoji"];

      // Check if they match and update counter if they do
      if (hasMatchingPair) {
        tileRevealCount += 2;
        revealedTiles.forEach((tile) => updateTileMap(tile["id"]));
        render();
        revealedTiles.clear();
      } else {
        Timer(Duration(milliseconds: 700), () {
          revealedTiles.forEach((tile) => updateTileMap(tile["id"], false));
          render();
          revealedTiles.clear();
        });
      }
    }
  }

  void updateTileMap(int id, [bool visible = true]) {
    List<Map> tilesCopy = List.from(_tiles);
    var updatedTile = tilesCopy.singleWhere((tile) => tile["id"] == id,
        orElse: () => null)
      ..update("isVisible", (val) => visible);

    tilesCopy[id] = updatedTile;
    _tiles = tilesCopy.toList();
  }

  void render() {
    querySelector(stage)
      ..innerHtml = ''
      ..append(
          new Grid(wrapperClass: 'memory-game-grid', tiles: _tiles).generate());
  }
}
