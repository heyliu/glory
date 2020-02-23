library style;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GTextStyle{
  static const S14_BLACK = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  static const S15_BLACK = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  static const S15_BOLD = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    height: 1.2,
  );
}

class GStyle {
  const GStyle._();


}

var textContent = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

var textTitle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  height: 1.2,
);
