import 'dart:html';

typedef VisibilityChangeCallback = void Function(bool isHidden);

class Dialog {
  Dialog(dialogSelector,
      {this.isHidden = true, this.onVisibilityChange, this.closeBtnSelector}) {
    _dialog = querySelector(dialogSelector)..hidden = isHidden;

    if (closeBtnSelector is String) {
      _closeBtn = querySelector(closeBtnSelector)
        ..addEventListener('click', (_) => hide());
    }
  }

  DivElement _dialog;
  bool isHidden;
  String closeBtnSelector;
  Element _closeBtn;
  VisibilityChangeCallback onVisibilityChange;

  void show() {
    _dialog.hidden = false;

    if (onVisibilityChange is VisibilityChangeCallback)
      onVisibilityChange(false);
  }

  void hide() {
    _dialog.hidden = true;

    if (onVisibilityChange is VisibilityChangeCallback)
      onVisibilityChange(true);
  }
}
