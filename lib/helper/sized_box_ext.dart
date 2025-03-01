import 'package:flutter/material.dart';

extension IntExtension on int {
  int validate({int value = 0}) {
    return this;
  }

  Widget get kH => SizedBox(
        height: toDouble(),
      );
  Widget get kW => SizedBox(
        width: toDouble(),
      );
}

extension MyPadding on Widget {
  Widget myPadding({required double val}) {
    return Padding(
      padding: EdgeInsets.only(left: val, right: val),
      child: this,
    );
  }
}
