import 'dart:html';
import './grid.dart';

class MemoryGame {
  MemoryGame(this.stage) {
    initActionBtns();
  }

  ButtonElement btnStart = querySelector('.action-btns__start');
  ButtonElement btnReset = querySelector('.action-btns__reset');

  final String stage;
  MemoryGameState gameState = MemoryGameState.beforeStart;

  void initActionBtns() {
    btnStart.addEventListener('click', (Event evt) {
      if (gameState == MemoryGameState.beforeStart) {
        init(false);
        gameState = MemoryGameState.started;
        btnStart.disabled = true;
        btnReset.disabled = false;
      }
    });

    btnReset.addEventListener('click', (Event evt) {
      if (gameState == MemoryGameState.started ||
          gameState == MemoryGameState.ended) {
        init(true);
        gameState = MemoryGameState.beforeStart;
        btnReset.disabled = true;
        btnStart.disabled = false;
      }
    });
  }

  void init(bool disabled) {
    querySelector(stage)
      ..firstChild.remove()
      ..append(new Grid(wrapperClass: 'memory-game-grid', disabled: disabled)
          .generate());
  }
}

enum MemoryGameState { beforeStart, started, ended }
