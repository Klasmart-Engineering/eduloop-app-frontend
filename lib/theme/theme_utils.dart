import 'package:flutter/material.dart';

Color fadeOnDisable(Set<MaterialState> states, Color color,
    [double opacity = .5]) {
  if (states.contains(MaterialState.disabled)) {
    return color.withOpacity(opacity);
  }

  return color;
}
