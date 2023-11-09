import 'package:flutter/material.dart';

import '../Config/Colorcfg.dart';

Widget TextFieldWidget(
    TextEditingController controller, bool ispassowrd, String hint) {
  return TextField(
    controller: controller,
    obscureText: ispassowrd,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Dark),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primery),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primery),
      ),
    ),
  );
}
