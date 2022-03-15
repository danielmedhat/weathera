
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  static inti() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.openweathermap.org/',
      receiveDataWhenStatusError: true,
      
    ));
  }

  static Future<Response> getDta(
    
      { required Map<String, dynamic> query,
         
         
       required String url}) async {
         return await dio!.get(url,queryParameters: query);
        
        }
    // return await dio.get(
    //   url,
    //   queryParameters: query,
      
   // );
  

  
}