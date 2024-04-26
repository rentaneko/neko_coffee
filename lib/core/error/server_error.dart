import 'package:dio/dio.dart';

class ServerError {
  late String timestamp;
  late int status;
  late String error;
  late String message;

  ServerError.network() {
    timestamp = DateTime.now().toString();
    status = 400;
    error = 'Bad Request';
    message = 'Không có kết nối mạng';
  }

  ServerError.timeout() {
    timestamp = DateTime.now().toString();
    status = 403;
    error = 'Bad Request';
    message = 'Quá thời gian kết nối';
  }

  ServerError.other() {
    timestamp = DateTime.now().toString();
    status = 500;
    error = 'Bad Request';
    message = 'Lỗi hệ thống';
  }

  ServerError.cancel() {
    timestamp = DateTime.now().toString();
    status = 600;
    error = 'Bad Request';
    message = 'Từ chối truy cập';
  }

  ServerError.format() {
    timestamp = DateTime.now().toString();
    status = 700;
    error = 'Bad Request';
    message = 'Lỗi định dạng';
  }

  ServerError.appError() {
    timestamp = DateTime.now().toString();
    status = 700;
    error = 'Bad Request';
    message = 'Ứng dụng bị lỗi';
  }

  ServerError.unknown() {
    timestamp = DateTime.now().toString();
    status = 999;
    error = 'Unknow Error';
    message = 'Lỗi không xác định';
  }

  ServerError.custom(
      {required String msg, String? errorMsg, String? time, int? statusCode}) {
    timestamp = time ?? DateTime.now().toString();
    status = statusCode ?? 999;
    error = errorMsg ?? 'An error occurred';
    message = msg;
  }

  static ServerError handleException(DioException dioException) {
    switch (dioException.type) {
      case DioException.badResponse:
        return ServerError.format();

      case DioExceptionType.connectionTimeout:
        return ServerError.timeout();

      case DioExceptionType.sendTimeout:
        return ServerError.timeout();

      case DioExceptionType.unknown:
        return ServerError.unknown();

      case DioExceptionType.connectionError:
        return ServerError.network();

      default:
        return ServerError.appError();
    }
  }
}
