import 'dart:html';

import 'package:memory_game_web/src/game.dart';

void main() {
  startApp();
}

void startApp() {
  ButtonElement btnStart = querySelector('.action-btns__start');
  ButtonElement btnReset = querySelector('.action-btns__reset');

  MemoryGame game = new MemoryGame('#output');

  btnStart.addEventListener('click', (Event evt) {
    if (game.state == MemoryGameState.beforeStart) {
      game.start();
      btnStart.disabled = true;
      btnReset.disabled = false;
    }
  });

  btnReset.addEventListener('click', (Event evt) {
    if (game.state == MemoryGameState.started ||
        game.state == MemoryGameState.ended) {
      game.reset();
      btnReset.disabled = true;
      btnStart.disabled = false;
    }
  });
}
