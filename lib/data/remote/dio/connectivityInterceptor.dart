import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'InternetStatusManager.dart';
//updated on 30-07-8

class ConnectivityInterceptor extends InterceptorsWrapper {
  final Connectivity connectivity;
  final InternetStatusManager internetManager = InternetStatusManager();

  ConnectivityInterceptor({required this.connectivity});

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // Check connectivity (Wi-Fi, Mobile, Ethernet)
      final connectivityResults = await connectivity.checkConnectivity();
      final isConnectedToNetwork = connectivityResults.any((result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);

      // If not connected to any network, block request
      if (!isConnectedToNetwork) {
        internetManager.isConnected.value = false;
        return handler.reject(_buildDioError(options));
      }

      // ✅ Set connection to true
      internetManager.isConnected.value = true;

      return super.onRequest(options, handler);
    } catch (e) {
      internetManager.isConnected.value = false;
      return handler.reject(_buildDioError(options));
    }
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError) {
      internetManager.isConnected.value = false;
    }

    return super.onError(err, handler);
  }

  DioException _buildDioError(RequestOptions options) {
    return DioException(
      requestOptions: options,
      error: 'No Internet Connection',
      type: DioExceptionType.connectionError,
      message: 'Check your internet connection',
    );
  }
}


// 2. UPDATED CONNECTIVITY INTERCEPTOR
/*class ConnectivityInterceptor extends InterceptorsWrapper {
  final Connectivity connectivity;
  final InternetStatusManager internetManager = InternetStatusManager();

  ConnectivityInterceptor({required this.connectivity});

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // Check connectivity
      List<ConnectivityResult> connectivityResults = await connectivity.checkConnectivity();
      bool isConnectedToNetwork = connectivityResults.any((result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);

      if (!isConnectedToNetwork) {
        internetManager.isConnected.value = false;
        return handler.reject(_buildDioError(options));
      }

      // Check actual internet access
      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;

      if (!hasInternet) {
        internetManager.isConnected.value = false;
        return handler.reject(_buildDioError(options));
      }

      // Update status to connected
      internetManager.isConnected.value = true;
      return super.onRequest(options, handler);

    } catch (e) {
      internetManager.isConnected.value = false;
      return handler.reject(_buildDioError(options));
    }
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Update internet status on connection errors
    if (err.type == DioExceptionType.connectionError) {
      internetManager.isConnected.value = false;
    }

    return super.onError(err, handler);
  }

  DioException _buildDioError(RequestOptions options) {
    return DioException(
      requestOptions: options,
      error: 'No Internet Connection',
      type: DioExceptionType.connectionError,
      message: 'Check your internet connection',
    );
  }
}*/
//old code

/*bool isInternet = true;
class ConnectivityInterceptor extends InterceptorsWrapper {
  final Connectivity connectivity;

  ConnectivityInterceptor({required this.connectivity});

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // Step 1: Check if user is on any network
      List<ConnectivityResult> connectivityResults = await connectivity.checkConnectivity();
      bool isConnectedToNetwork = connectivityResults.any((result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);

      if (!isConnectedToNetwork) {
        _logNoInternet();
        return handler.reject(_buildDioError(options)); // ✅ Fixed: Removed extra 'true'
      }

      // Step 2: Confirm actual internet access
      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
      log('🔍 Internet status: $hasInternet');

      if (!hasInternet) {
        _logNoInternet();
        return handler.reject(_buildDioError(options)); // ✅ Fixed: Removed extra 'true'
      }

      // Update global internet status
      isInternet = true;
      return super.onRequest(options, handler);

    } catch (e) {
      if (kDebugMode) {
        debugPrint('Connectivity check error: $e');
      }
      // If connectivity check fails, proceed with the request
      return super.onRequest(options, handler);
    }
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      debugPrint("Dio Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    }

    // Update global internet status on connection errors
    if (err.type == DioExceptionType.connectionError) {
      isInternet = false;
    }

    return super.onError(err, handler);
  }

  void _logNoInternet() {
    isInternet = false;
    if (kDebugMode) {
      debugPrint('NO INTERNET CONNECTION ❌');
    }
  }

  DioException _buildDioError(RequestOptions options) {
    return DioException(
      requestOptions: options,
      error: 'No Internet Connection',
      type: DioExceptionType.connectionError,
      message: 'Check your internet connection',
    );
  }
}*/











