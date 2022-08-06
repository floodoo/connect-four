import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ColorUtil {
  static const _colorHex = 0xffbcbcbc;
  static const _primary = Color(_colorHex);
  static MaterialColor get primaryColor => MaterialColor(_colorHex, {
        50: _primary.withOpacity(.1),
        100: _primary.withOpacity(.2),
        200: _primary.withOpacity(.3),
        300: _primary.withOpacity(.4),
        400: _primary.withOpacity(.5),
        500: _primary.withOpacity(.6),
        600: _primary.withOpacity(.7),
        700: _primary.withOpacity(.8),
        800: _primary.withOpacity(.9),
        900: _primary.withOpacity(1),
      });

  static bool get isLightMode {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.light;
  }
}
