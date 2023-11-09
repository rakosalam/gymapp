import 'package:flutter/material.dart';

import '../Config/Colorcfg.dart';

Widget container_button(String text, Color _color, Color _Textcolor) {
  return Container(
    padding: EdgeInsets.all(25),
    margin: EdgeInsets.all(25),
    decoration:
        BoxDecoration(color: _color, borderRadius: BorderRadius.circular(8)),
    child: Center(
      child: Text(
        (text),
        style: TextStyle(
            color: _Textcolor, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

//////////////// nav buttons

Widget navbuttons(String text, IconData _icon) {
  return Row(children: [
    Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Center(
        child: Icon(
          _icon,
          color: primery,
          size: 35,
        ),
      ),
    ),
    SizedBox(
      width: 20,
    ),
    Expanded(
      child: Text(
        text,
        style:
            TextStyle(color: Dark, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
    Icon(Icons.arrow_forward_ios)
  ]);
}
