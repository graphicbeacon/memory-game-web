import 'dart:html';

typedef ShowCallback = void Function(String emoji);

class Tile {
  Tile({this.emoji, this.onShow, this.onHide}) : _btn = new ButtonElement();

  final String emoji;
  ButtonElement _btn;
  ShowCallback onShow;
  VoidCallback onHide;

  ButtonElement generate() {
    return _btn..addEventListener('click', _onClick);
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
