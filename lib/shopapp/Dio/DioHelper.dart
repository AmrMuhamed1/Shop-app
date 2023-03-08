import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Diohelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getdata({
    required String url,
     Map<String, dynamic> ?query,
    String? token,
    String lang='en',
  }) async
  {
    dio.options.headers ={
      'Authorization':token??'',
      'Content-Type':'application/json',
      'lang':lang,


    };
    return await dio.get(url, queryParameters: query,);
  }



  static Future<Response> postdata({
    required String url,
     Map<String, dynamic> ?query,
    String ?token,
    required Map<String, dynamic> data,
    String lang='en',
  }) async {
    dio.options.headers ={
      'Authorization':token??'',
      'Content-Type':'application/json',
      'lang':lang,

    };

    return dio.post(url,queryParameters: query,data: data);
  }



  static Future<Response> putdata({
    required String url,
    Map<String, dynamic> ?query,
    String ?token,
    required Map<String, dynamic> data,
    String lang='en',
  }) async {
    dio.options.headers ={
      'Authorization':token??'',
      'Content-Type':'application/json',
      'lang':lang,

    };

    return dio.put(url,queryParameters: query,data: data);
  }
}
