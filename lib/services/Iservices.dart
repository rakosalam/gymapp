import 'package:dio/dio.dart';

abstract class Iservices{

  Future<Response> Getcustomers(int id);

  Future<Response> GetHistory(int id);

  Future<Response> Login(String uname, String password );

  Future<Response> getImage(int id);

  Future<Response> updatepassword(int id, String oldpassword , String password );

  Future<Response> Updateimage( int id , FormData file );

  Future<Response> GetFoods(int id);

  Future<Response> getworkouts(int id);

  Future<Response> PostRequest(int cus_id , int tr_id , DateTime date , int isdiet , int isworkout , String desc , int status , int id );








}