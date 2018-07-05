import 'dart:html';
import './tile.dart';

class Grid {
  final String wrapperClass;
  final List<Map> tiles;

  Grid({this.wrapperClass, this.tiles});

  DocumentFragment generate() {
    var gridFragment = new DocumentFragment();
    gridFragment.append(new DivElement()..className = this.wrapperClass);
    var numberOfTiles = tiles.length;

    for (var ii = 0; ii < numberOfTiles; ii++) {
      gridFragment.firstChild.append(Tile.fromMap(tiles[ii]).generate());
    }

    return gridFragment;
  }
}
