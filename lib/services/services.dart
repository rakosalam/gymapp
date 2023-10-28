import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart';
import 'package:dio/src/response.dart';
import 'package:gymapp/services/Iservices.dart';

class services extends Iservices {
  @override
  final dio = Dio();

  @override
  Future<Response> GetFoods(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Response> GetHistory(int id) async {
    try {
      Response response = await dio.get(
        'Customer/GetHistory',
        queryParameters: {'id': id},
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  @override
  Future<Response> Getcustomers(int id) async {
    try {
      final Response response = await dio.get(
        '/Customer/GetCustomer',
        queryParameters: {'id': id},
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  @override
  Future<Response> Login(String uname, String password) async {
    try {
      final Response response = await dio.post(
        '/Customer/login',
        data: {
          'uname': uname,
          'password': password,
        },
      );

      return response;
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  @override
  Future<Response> postRequest(int cus_id, int tr_id, DateTime date, int isdiet,
      int isworkout, String desc, int status, int id) async {
    try {
      final Response response = await dio.post(
        '/Request/PostRequest',
        data: {
          'cus_id': cus_id,
          'tr_id': tr_id,
          'date': date.toIso8601String(),
          'isdiet': isdiet,
          'isworkout': isworkout,
          'desc': desc,
          'status': status,
          'id': id,
        },
      );

      return response;
    } catch (e) {
      throw Exception('Failed to make the POST request: $e');
    }
  }

  @override
  Future<Response> Updateimage(int id, FormData file) async {
    try {
      final Response response = await dio.post(
        '/Customer/UpdateImage',
        data: {
          'id': id,
          'file': file,
        },
      );

      return response;
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  @override
  Future<Response> getImage(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Response> getworkouts(int id) async {
    try {
      Response response = await dio.get(
        '/Workout/getworkouts',
        queryParameters: {'id': id},
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  @override
  Future<Response> updatepassword(
      int id, String oldpassword, String password) async {
    try {
      final Response response = await dio.post(
        'Customer/updatepassword',
        data: {
          'id': id,
          'oldpassword': oldpassword,
          'password': password,
        },
      );

      return response;
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  @override
  Future<Response> PostRequest(int cus_id, int tr_id, DateTime date, int isdiet,
      int isworkout, String desc, int status, int id) {
    // TODO: implement PostRequest
    throw UnimplementedError();
  }
}
