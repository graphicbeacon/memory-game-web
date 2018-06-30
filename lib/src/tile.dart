import 'dart:html';

typedef ShowCallback = void Function(String emoji);

class Tile {
  Tile({
    this.emoji,
    this.onShow,
    this.onHide,
    this.disabled,
  }) : _btn = new ButtonElement();

  Tile.fromMap(Map config)
      : this(
          emoji: config["emoji"],
          onShow: config["onShow"],
          onHide: config["onHide"],
          disabled: config["disabled"],
        );

  final String emoji;
  final ButtonElement _btn;
  final ShowCallback onShow;
  final VoidCallback onHide;
  bool disabled;

  ButtonElement generate() {
    return _btn
      ..disabled = disabled
      ..addEventListener('click', _onClick);
  }

  void _onClick(Event evt) {
    if (_btn.text == emoji) {
      _btn.text = '';
      onHide();
    } else {
      _btn.text = emoji;
      onShow(emoji);
    }
  }
}
