import 'package:dio/dio.dart';
import 'package:gymapp/models/RequestModel.dart';
import 'package:image_picker/image_picker.dart';

abstract class IServices {
  Future<Response> Getcustomers(int id);

  Future<Response> GetHistory(int id);

  Future<Response> Login(String uname, String password);

  Future<Response> getImage(int id);

  Future<Response> updatepassword(int id, String oldpassword, String password);

  Future<Response> Updateimage(int id, XFile file);

  Future<Response> GetFoods(int id);

  Future<Response> getworkouts(int id);

  Future<Response> PostRequest(RequestModel request);
  Future<Response> ShowTrainer();
}
