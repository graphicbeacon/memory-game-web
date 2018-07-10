import 'dart:async';
import 'dart:html';

class Watch {
  Watch(clockSelector) {
    _clockSelector = querySelector(clockSelector);
    render();
  }

  int _hours = 0, _mins = 0, _secs = 0;
  Element _clockSelector;
  Timer _timer;
  String currentTime;

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _secs++;

      if (_secs >= 60) {
        _secs = 0;
        _mins++;

        if (_mins >= 60) {
          _mins = 0;
          _hours++;
        }
      }

      render();
    });
  }

  void stop() {
    if (_timer.isActive) _timer.cancel();
  }

  void reset() {
    stop();

    _hours = 0;
    _mins = 0;
    _secs = 0;

    render();
  }

  void render() {
    var hh = _hours.toString(), mm = _mins.toString(), ss = _secs.toString();

    if (_hours < 10) hh = '0$_hours';
    if (_mins < 10) mm = '0$_mins';
    if (_secs < 10) ss = '0$_secs';

    currentTime = '$hh:$mm:$ss';
    _clockSelector..innerHtml = currentTime;
  }
}
