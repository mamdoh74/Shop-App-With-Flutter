import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;
  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true ,
          headers: {

          },
        ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String , dynamic>? query,
  }) async {
    return await dio.get(url , queryParameters: query,);
  }

  static Future<Response> PostData({
    required String url,
    Map<String , dynamic>? query,
    required Map<String , dynamic> data,
    String lang = 'en',
    String? Authorization,
  }) async {
    dio.options.headers= {
      'lang': lang,
      'Authorization': Authorization,
      'Content-Type':'application/json',
    };
    return await dio.post(
      url ,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> GetData({
    required String url,
    Map<String , dynamic>? query,
    String lang = 'en',
    String? Authorization,
  }) async {
    dio.options.headers= {
      'lang': lang,
      'Authorization': Authorization??'',
      'Content-Type':'application/json',
    };
    return await dio.get(
      url ,
      queryParameters: query ?? null,
    );
  }

  static Future<Response> PutData({
    required String url,
    Map<String , dynamic>? query,
    required Map<String , dynamic> data,
    String lang = 'en',
    String? Authorization,
  }) async {
    dio.options.headers= {
      'lang': lang,
      'Authorization': Authorization,
      'Content-Type':'application/json',
    };
    return await dio.put(
      url ,
      queryParameters: query,
      data: data,
    );
  }
}