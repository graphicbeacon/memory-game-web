import 'dart:html';
import 'dart:async';

import './emoji.dart';
import './grid.dart';
import './tile.dart';
import './game.dart';

class MemoryGameBoard {
  MemoryGameBoard(this.stage, this.onComplete);

  static final int numberOfTiles = 16;
  String stage;
  final Set emojis = new EmojiService().getCollection(numberOfTiles);
  List<Map> _tiles;
  MemoryGameState _state; // TODO: Remove _state
  VoidCallback onComplete;

  int tileRevealCount = 0;
  List<Map> revealedTiles = [];

  // TODO: Remove _state
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
    }

    while (i < numberOfTiles) {
      tiles.add({
        "id": i,
        "emoji": isBeforeStart ? null : emojiList[i],
        "onClick": isBeforeStart ? null : openTileCallback,
        "isVisible": false,
        "disabled": isBeforeStart,
        "state": null,
      });
      i++;
    }
    this._tiles = tiles;
  }

  void openTileCallback(int id) {
    if (revealedTiles.length < 2) {
      revealedTiles.add(_tiles[id]);
      updateTileMap(id, true, TileState.select);
      render();
    }

    if (revealedTiles.length == 2) {
      var hasMatchingPair =
          revealedTiles[0]["emoji"] == revealedTiles[1]["emoji"];

      // Check if they match and update `tileRevealCount` if they do
      if (hasMatchingPair) {
        tileRevealCount += 2;
        updateTiles(true, TileState.match);
        revealedTiles.clear();

        // All tiles revealed, so end game
        if (tileRevealCount == numberOfTiles) onComplete();
      } else {
        updateTiles(true, TileState.noMatch);
        Timer(Duration(milliseconds: 700), () {
          updateTiles(false);
          revealedTiles.clear();
        });
      }
    }
  }

  void updateTiles(isVisible, [TileState tileState = null]) {
    revealedTiles
        .forEach((tile) => updateTileMap(tile["id"], isVisible, tileState));
    render();
  }

  void updateTileMap(int id,
      [bool visible = true, TileState tileState = null]) {
    List<Map> tilesCopy = List.from(_tiles);
    var updatedTile = tilesCopy.singleWhere((tile) => tile["id"] == id,
        orElse: () => null)
      ..update("isVisible", (val) => visible)
      ..update("state", (val) => tileState);

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
