import 'dart:html';
import './grid.dart';

class MemoryGame {
  MemoryGame(this.stage) {
    setCommands();
  }

  final String stage;
  MemoryGameState gameState = MemoryGameState.beforeStart;

  void setCommands() {
    // TODO: Only disable button when game has started
    querySelector('.action-btns__new')
      ..addEventListener('click', (Event evt) {
        if (gameState == MemoryGameState.beforeStart) {
          start(false);
          gameState = MemoryGameState.started;
        }
      });

    // TODO: Only enable button when game has started
    querySelector('.action-btns__reset')
      ..addEventListener('click', (Event evt) {
        if (gameState == MemoryGameState.started ||
            gameState == MemoryGameState.ended) {
          start(true);
          gameState = MemoryGameState.beforeStart;
        }
      });
  }

  void start(bool disabled) {
    querySelector(stage)
      ..firstChild.remove()
      ..append(new Grid(wrapperClass: 'memory-game-grid', disabled: disabled)
          .generate());
  }
}

enum MemoryGameState { beforeStart, started, ended }
