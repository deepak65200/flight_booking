
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_constant.dart';
import '../model/base/api_response.dart';
import '../model/response/search_request.dart';
import '../remote/dio/dioClient.dart';
import '../remote/exception/apiErrorHandler.dart';

// class FlightRepo {
//   final DioClient dioClient;
//
// final SharedPreferences sharedPreferences;
//   FlightRepo({required this.dioClient, required this.sharedPreferences});
//
//
//   Future<ApiResponse> getAirports(String query) async {
//     try {
//       final response = await dioClient.get(ApiConstants.airports);
//       return ApiResponse.withSuccess(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
//
//   Future<ApiResponse> searchFlights(SearchRequest request) async {
//     try {
//       final response = await dioClient.post(
//         ApiConstants.searchFlights,
//         data: request.toJson(),
//       );
//       return ApiResponse.withSuccess(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
//
//   Future<ApiResponse> getFlightDetails(String id) async {
//     try {
//       final response =
//       await dioClient.get("${ApiConstants.flightDetails}/$id");
//       return ApiResponse.withSuccess(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
// }

import '../remote/mock/mock_api_service.dart';


class FlightRepo {
  final DioClient dioClient;
final SharedPreferences sharedPreferences;

  FlightRepo({required this.dioClient, required this.sharedPreferences});

  /// GET /airports
  Future<ApiResponse> getAirports() async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final jsonString =
      await rootBundle.loadString('assets/json/airports.json');
      final data = json.decode(jsonString);

      return ApiResponse.withSuccess(
        Response(
          requestOptions: RequestOptions(path: '/airports'),
          statusCode: 200,
          data: data,
        ),
      );
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// POST /flights/search
  Future<ApiResponse> searchFlights(SearchRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final jsonString =
      await rootBundle.loadString('assets/json/flights.json');
      final data = json.decode(jsonString);

      return ApiResponse.withSuccess(
        Response(
          requestOptions: RequestOptions(path: '/flights/search'),
          statusCode: 200,
          data: data,
        ),
      );
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// GET /flights/:id
  Future<ApiResponse> getFlightDetails(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 700));

      final jsonString =
      await rootBundle.loadString('assets/json/flight_details.json');
      final data = json.decode(jsonString);

      return ApiResponse.withSuccess(
        Response(
          requestOptions: RequestOptions(path: '/flights/$id'),
          statusCode: 200,
          data: data,
        ),
      );
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
