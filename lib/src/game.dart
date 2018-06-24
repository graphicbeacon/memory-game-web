import 'dart:html';
import './grid.dart';

class MemoryGame {
  MemoryGame(this.stage);

  final String stage;

  void start() {
    querySelector(stage)
      ..firstChild.remove()
      ..append(new Grid().generate());
  }
}
