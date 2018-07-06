import './board.dart';

class MemoryGame {
  MemoryGame(this.stage, {this.onComplete}) {
    board = new MemoryGameBoard(stage, onComplete);
    state = MemoryGameState.beforeStart;
    board.render();
  }

  final String stage;
  MemoryGameBoard board;
  MemoryGameState _state;
  Function onComplete;

  get state => _state;
  set state(MemoryGameState val) {
    _state = val;
    board.state = _state;
  }

  void start() {
    state = MemoryGameState.started;
    board.render();
  }

  void reset() {
    board = new MemoryGameBoard(stage, onComplete);
    state = MemoryGameState.beforeStart;
    board.render();
  }
}

enum MemoryGameState { beforeStart, started, ended }
