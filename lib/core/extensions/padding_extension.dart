import 'package:flutter/cupertino.dart';

extension PaddingExtensions on Widget {
  Widget allPadding(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget symetricalPadding({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget onlyPadding(
      {double top = 0, double bot = 0, double left = 0, double right = 0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bot, right: right, top: top, left: left),
      child: this,
    );
  }
}
