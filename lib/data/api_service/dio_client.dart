// ignore_for_file: avoid_print, deprecated_member_use

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/bloc.dart';
import 'package:dio/dio.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_preferences.dart';

import 'interceptors/pretty_dio_logger.dart';
import 'interceptors/retry_interceptor.dart';

class DioClient {
  late final Dio dio;

  final List<String> rejectCode = ['jwt expired', 'un_authorized', 'user_not_found'];

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstant.urlUser,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: 1,
      retryDelays: const [
        Duration(seconds: 1),
      ],
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Map<String, dynamic> headers = {"Connection": "Keep-Alive", "Keep-Alive": "timeout=5, max=10000"};
          String? token = UtilPreferences.getString(AppConstant.accessToken);
          if (token != null) {
            headers["Authorization"] = "Bearer $token";
          }
          print('Token: $token');
          options.headers.addAll(headers);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          if (error.type != DioErrorType.response) {
            return handler.next(error);
          }

          if (error.response?.data is String?) {
            /// Show error message
            AppBloc.messageBloc.add(OnHttpMessage(
              resultApi: ResultApiModel(
                success: false,
                message: '[${error.response?.statusCode}] ${error.response?.statusMessage}',
                data: {},
                statusCode: error.response?.statusCode,
              ),
            ));
            return handler.next(error);
          }
          final message = error.response?.data['message'];

          ///Logout
          if (rejectCode.contains(message)) {
            dio.lock();
            dio.interceptors.responseLock.lock();
            dio.interceptors.errorLock.lock();
            await AppBloc.authenticationCubit.onClear();
            dio.unlock();
            dio.interceptors.responseLock.unlock();
            dio.interceptors.errorLock.unlock();
          }
          final response = Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
          );
          return handler.resolve(response);
        },
      ),
    );
  }

  ///Post method
  Future<dynamic> post({required String url, dynamic data, Map<String, dynamic>? params, Options? options}) async {
    Dio request = dio;
    try {
      final response = await request.post(
        url,
        data: data,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({required String url, Map<String, dynamic>? params, Options? options}) async {
    Dio request = dio;
    try {
      final response = await request.get(
        url,
        queryParameters: params,
        options: Options(),
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error);
    }
  }

  ///Put method
  Future<dynamic> put({required String url, Map<String, dynamic>? data, Map<String, dynamic>? params, Options? options}) async {
    Dio request = dio;
    try {
      final response = await request.put(
        url,
        data: data,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error);
    }
  }

  ///Put method
  Future<dynamic> delete({required String url, Map<String, dynamic>? data, Map<String, dynamic>? params, Options? options}) async {
    Dio request = dio;
    try {
      final response = await request.delete(
        url,
        data: data,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error);
    }
  }

  ///Error common handle
  Map<String, dynamic> errorHandle(DioError error) {
    String message = "unknown_error";
    Map<String, dynamic> data = {};

    switch (error.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        message = "cannot_connect_server";
        break;
    }

    return {
      "success": false,
      "msg": message,
      "data": data,
    };
  }
}
