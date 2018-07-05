import 'dart:html';

typedef OnClickCallback = void Function(int emoji);

class Tile {
  Tile({
    this.id,
    this.emoji,
    this.onClick,
    this.isVisible,
    this.disabled,
    this.state,
  }) : _btn = new ButtonElement() {
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
          state: config["state"],
        );

  final ButtonElement _btn;
  final int id;
  final String emoji;
  final OnClickCallback onClick;
  final TileState state;
  bool isVisible;
  bool disabled;

  ButtonElement generate() {
    return _btn
      ..disabled = state == TileState.match ? true : disabled
      ..className = state == TileState.select
          ? "select"
          : state == TileState.match
              ? "match"
              : state == TileState.noMatch ? "no-match" : ""
      ..addEventListener(
          'click', (Event evt) => isVisible ? null : onClick(id));
  }
}

enum TileState { select, match, noMatch }
