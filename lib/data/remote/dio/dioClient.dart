import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/navHelper.dart';
import '../../../utils/preferences.dart';
import '../../../widgets/common_method.dart';
import '../exception/apiErrorHandler.dart';
import 'connectivityInterceptor.dart';
import 'loggingInterceptor.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor? loggingInterceptor;
  final SharedPreferences? sharedPreferences;
  final ConnectivityInterceptor? connectivityInterceptor;

  late Dio dio;
  String token = '';
  String userId = '';

  DioClient(this.baseUrl, Dio dioC,
      {this.loggingInterceptor,
        this.sharedPreferences,
        this.connectivityInterceptor}) {
    if (sharedPreferences!.containsKey(Preferences.userToken)) {
      token = sharedPreferences!.getString(Preferences.userToken)!;
      if (kDebugMode) {
        print("USER_TOKEN>>>> $token");
      }
    }
    if (sharedPreferences!.containsKey(Preferences.userId)) {
      userId = sharedPreferences!.getString(Preferences.userId)!;
      if (kDebugMode) {
        print("USER_ID>>>> $userId");
      }
    }

    dio = dioC;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'userKey': token,
        'id': userId
      };

    dio.interceptors.add(connectivityInterceptor!);
    dio.interceptors.add(loggingInterceptor!);

    // Add the new interceptor to handle API responses with custom error codes
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Check if API response contains an error message inside a 200 response
        if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
          if (response.data.containsKey("code") && response.data["code"] == "402") {

            _handleSessionExpired();

            handler.reject(DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              error: response.data["message"] ?? "Session Expired",
            ));
            return;
          }
        }
        handler.next(response); // Continue with response if no issue
      },

      onError: (DioException error, ErrorInterceptorHandler handler) {
        // Use your existing ApiErrorHandler to format the error message
        final errorMessage = ApiErrorHandler.getMessage(error);

        handler.reject(DioException(
          requestOptions: error.requestOptions,
          response: error.response,
          type: error.type,
          error: errorMessage,
        ));
      },
    ));

  }

  Future<Response> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      debugPrint('===============${e.toString()}');
      rethrow;
    }
  }

  Future<Response> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      if (kDebugMode && data != null) print("PARAMS>>>>> $data");

      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print('response>>>>::$response');
      }
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  void _handleSessionExpired() {
    Future.delayed(Duration.zero, () {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null || !context.mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔥 Use an Icon instead of animation
                  Icon(
                    Icons.warning_rounded,
                    size: 60,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 12),

                  // 📢 Title
                  Text(
                    "Session Expired",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // 📝 Updated Message
                  Text(
                    "You’ve been logged out as your account was accessed from another device. Please sign in again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),

                  // 🔘 Re-login Button (Using commonButton)
                  commonButton(
                    dialogContext,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();

                      if (dialogContext.mounted) {
                        // Navigator.pushAndRemoveUntil(
                        //   dialogContext,
                        //   MaterialPageRoute(builder: (context) => SignInScreen()),
                        //       (route) => false,
                        // );
                      }
                    },
                    label: 'Re-login',
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

}
