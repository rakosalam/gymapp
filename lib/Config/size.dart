import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceSize {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}