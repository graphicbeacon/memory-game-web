import 'dart:html';

typedef OnClickCallback = void Function(int emoji);

class Tile {
  Tile({
    this.id,
    this.emoji,
    this.onClick,
    this.isVisible,
    this.disabled,
  }) : _btn = new ButtonElement() {
    print(isVisible);
    if (isVisible) {
      _btn.text = emoji;
    }
  }

  Tile.fromMap(Map config)
      : this(
          id: config["id"],
          emoji: config["emoji"],
          onClick: config["onClick"],
          isVisible: config["isVisible"],
          disabled: config["disabled"],
        );

  final ButtonElement _btn;
  final int id;
  final String emoji;
  final OnClickCallback onClick;
  bool isVisible;
  bool disabled;

  ButtonElement generate() {
    return _btn
      ..disabled = disabled
      ..addEventListener('click', (Event evt) => onClick(id));
  }
}
