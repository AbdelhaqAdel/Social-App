import 'package:dio/dio.dart';

abstract class Failure{
  String message;
  Failure(this.message);
}

class ServerFailure extends Failure{
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e){
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      return ServerFailure('Connection timeout with API server');
     
      case DioExceptionType.sendTimeout:
      return ServerFailure('Send timeout with API server');

      case DioExceptionType.receiveTimeout:
      return ServerFailure('Receive timeout with API server');

      case DioExceptionType.badResponse:
      return ServerFailure.responseError(e.response!.statusCode!, e.response);
     
      case DioExceptionType.cancel:
      return ServerFailure('Request from API was canceled');
     
      default:
      return ServerFailure('Opps. there was an error, please try again');
    }
  }

  factory ServerFailure.responseError(int statusCode,dynamic response){
     if(statusCode==404){ 
      return ServerFailure('Your request not found, please try later');
     }else if(statusCode==500){
      return ServerFailure('there is a problem with server please try again');

     }else if(statusCode==400||statusCode==401||statusCode==403){
      //---its depend on message from api response
      return ServerFailure('Message from Api');
     }else{
      return ServerFailure('there was an error please try again');
     }
  }

}