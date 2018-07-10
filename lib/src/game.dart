import './board.dart';
import './watch.dart';

class MemoryGame {
  MemoryGame(this.stage, this.timerSelector, {this.onComplete}) {
    _board = new MemoryGameBoard(stage, _end);
    state = MemoryGameState.beforeStart;
    _timer = new Watch(timerSelector);
    _board.render();
  }

  final String stage;
  MemoryGameBoard _board;
  MemoryGameState _state;
  Watch _timer;
  String timerSelector;
  Function onComplete;

  get state => _state;
  set state(MemoryGameState val) {
    _state = val;
    _board.state = _state;
  }

  void start() {
    state = MemoryGameState.started;
    _timer.start();
    _board.render();
  }

  void _end() {
    state = MemoryGameState.ended;
    _timer.stop();

    if (onComplete is Function)
      onComplete(_timer.currentTime); // TODO return completion time?
  }

  void reset() {
    _board = new MemoryGameBoard(stage, _end);
    state = MemoryGameState.beforeStart;
    _timer.reset();
    _board.render();
  }
}

enum MemoryGameState { beforeStart, started, ended }
