import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/models/RequestModel.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:gymapp/services/services.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider with ChangeNotifier {
  late ResultModel result;

  final Services _services = Services();
  bool loading = false;

  Future<Response> login(String uname, String password) async {
    var res = await _services.Login(uname, password);

    print(res.statusCode);

    return res;
  }

  Future<Response> ShowHistory(int id) async {
    var res = await _services.GetHistory(id);

    print(res.statusCode);
    return res;
  }

  Future<Response> ShowFood(int id) async {
    var res = await _services.GetFoods(id);

    print(res.statusCode);
    return res;
  }

  Future<Response> ShowWorkouts(int id) async {
    var res = await _services.getworkouts(id);
    print(res);

    return res;
  }

  Future<Response> ShowcustomerData(int id) async {
    var res = await _services.Getcustomers(id);

    print(res.statusCode);
    return res;
  }

  Future<Response> showimage(int id) async {
    var res = await _services.getImage(id);

    print(res.statusCode);
    return res;
  }

  Future<Response> Updateimage(int id, XFile file) async {
    var res = await _services.Updateimage(id, file);

    print(res.statusCode);
    return res;
  }

  Future<Response> sendrequest(RequestModel request) async {
    var res = await _services.PostRequest(request);

    print(res.statusCode);
    return res;
  }

  Future<Response> Updatepassword(
      int id, String password, String oldpassword) async {
    var res = await _services.updatepassword(id, oldpassword, password);

    print(res.statusCode);
    return res;
  }

  Future<Response> ShowTrainer() async {
    var res = await _services.ShowTrainer();

    print(res.statusCode);
    return res;
  }
}
