// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/models/RequestModel.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:gymapp/services/services.dart';
import 'package:image_picker/image_picker.dart';

class Uiprovider with ChangeNotifier {
  bool showpassword = true;
  void setshowpassword(bool b) {
    showpassword = b;
    notifyListeners();
  }
}
