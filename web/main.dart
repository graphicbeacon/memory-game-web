import 'dart:html';

import 'package:memory_game_web/memory_game_web.dart';

void main() {
  startApp();
}

void startApp() {
  ButtonElement btnStart = querySelector('.action-btns__start');
  ButtonElement btnReset = querySelector('.action-btns__reset');
  Element completionContainer =
      querySelector('.modal__content__completion-time');

  Dialog modal =
      new Dialog('#modal', closeBtnSelector: '.action-btns__replay-game',
          onVisibilityChange: (isHidden) {
    print('Modal is ${isHidden ? "hidden" : "visible"}');

    if (isHidden) {
      // `Play again?` button was clicked
      btnReset.click();
    }
  });
  MemoryGame game =
      new MemoryGame('#output', '#timer', onComplete: (completionTime) {
    // Update before showing modal
    completionContainer..innerHtml = completionTime;
    modal.show();
  });

  btnStart
    ..disabled = false
    ..addEventListener('click', (Event evt) {
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
