
import 'package:dio/dio.dart';

class Dio_Helper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/',
      receiveDataWhenStatusError: true,
    ));
  }


  static Future<Response> GetData({
    required String url,
    Map<String, dynamic>? query,
    String? token
  }) async {
    dio.options.headers = {
      //   'lang':lang,
      //   'authorizatio':token??'',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> PostData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Map<String, dynamic>? data,


  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':'key=AAAAaQvVYmY:APA91bEht53IayiZHFXqlLXKBsastmDPayvymkWFbBF3U32L23YcmS10h5DrHkLBg44IpKr_GAuqSM9VOBw2TsL5UMxxXuGYGAoMDup5a6UsNmhoBNJ-CiXFE3m_S7I12QsaU7CJtQNC',
    };

    return await dio.post(
        url, queryParameters: query, data: data);
  }
}