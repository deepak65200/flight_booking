// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../model/base/error_response.dart';

class ApiErrorHandler {
  /// **Handles API errors and returns a user-friendly message**
  static String getMessage(dynamic error) {
    debugPrint("❌ Error Caught in ApiErrorHandler: ${error.toString()}");

    String errorDescription = "Something went wrong!";

    if (error is DioException) {
      debugPrint('🚨 DioException Detected: ${error.message}');
      debugPrint('🚨 DioException Type: ${error.type}');

      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = "Request was cancelled.";
          break;

        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timed out.";
          break;

        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout occurred.";
          break;

        case DioExceptionType.receiveTimeout:
          errorDescription = "Server took too long to respond.";
          break;

        case DioExceptionType.connectionError:
          errorDescription = error.message ?? "No Internet Connection.";
          break;

        case DioExceptionType.badResponse:
          errorDescription = _handleBadResponse(error.response);
          break;

        default:
          errorDescription = "An unexpected error occurred.";
      }
    } else {
      debugPrint("🚨 Non-Dio error occurred: $error");
      errorDescription = "Unexpected error occurred.";
    }

    debugPrint("❌ Processed API Error Message: $errorDescription");
    return errorDescription;
  }

  /// **Handles API response errors based on status codes**
  static String _handleBadResponse(Response? response) {
    if (response == null) {
      debugPrint("🚨 No response from server.");
      return "No response from server.";
    }

    int? statusCode = response.statusCode;
    dynamic responseData = response.data;

    debugPrint("🔴 API Response Error Handler Triggered");
    debugPrint("🔴 Status Code: $statusCode");
    debugPrint("🔴 Raw API Response: ${response.data}");

    String responseMessage = "Unknown error";

    // 🚀 Extract API error message if available
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey("message")) {
        responseMessage = responseData["message"];
      }
      // ✅ Check if response follows `ErrorResponse` model structure
      else {
        try {
          ErrorResponse errorResponse = ErrorResponse.fromJson(responseData);
          debugPrint("🔴 Parsed ErrorResponse: ${errorResponse.errors}");
          responseMessage = errorResponse.errors?.toString() ?? "An error occurred.";
        } catch (e) {
          debugPrint("❌ Error parsing ErrorResponse: $e");
        }
      }
    }

    // 🔥 Handle Specific Status Codes
    switch (statusCode) {
      case 400:
        responseMessage = "Invalid request. Please check your input.";
        break;
      case 401:
        responseMessage = "Unauthorized. Please log in.";
        break;
      case 402:
        responseMessage = "Session expired. Please log in again.";
       // _handleSessionExpired();
        break;
      case 403:
        responseMessage = "Access denied. You do not have permission.";
        break;
      case 404:
        responseMessage = "Requested resource not found.";
        break;
      case 500:
        responseMessage = "Server error. Please try again later.";
        break;
      case 503:
        responseMessage = "Service is temporarily unavailable.";
        break;
      default:
        responseMessage = "Unexpected error: $statusCode";
    }

    return responseMessage;
  }

  /// **Handles session expiration (e.g., logout, token refresh)**
  static void _handleSessionExpired() {
    debugPrint("⚠️ Session Expired! Redirecting to login...");
    // TODO: Implement session expiration handling (e.g., logout user, show login screen).
  }
}



