import 'dart:html';

import 'package:memory_game_web/src/game.dart';
import 'package:memory_game_web/src/watch.dart';

void main() {
  startApp();
}

void startApp() {
  ButtonElement btnStart = querySelector('.action-btns__start');
  ButtonElement btnReset = querySelector('.action-btns__reset');

  Watch timer = new Watch('#timer');
  MemoryGame game = new MemoryGame('#output', onComplete: () {
    timer.stop();
  });

  btnStart
    ..disabled = false
    ..addEventListener('click', (Event evt) {
      if (game.state == MemoryGameState.beforeStart) {
        game.start();
        timer.start();
        btnStart.disabled = true;
        btnReset.disabled = false;
      }
    });

  btnReset.addEventListener('click', (Event evt) {
    if (game.state == MemoryGameState.started ||
        game.state == MemoryGameState.ended) {
      game.reset();

      // Kill current timer and recreate
      timer.stop();
      timer = new Watch('#timer');

      btnReset.disabled = true;
      btnStart.disabled = false;
    }
  });
}
