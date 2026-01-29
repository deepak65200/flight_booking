import 'package:flutter/material.dart';

import '../data/model/base/api_response.dart';
import '../data/model/base/response_model.dart';
import '../data/model/response/flight_details.dart';
import '../data/remote/exception/apiErrorHandler.dart';
import '../data/repo/flight_repo.dart';

class FlightDetailsProvider extends ChangeNotifier {
  final FlightRepo flightRepo;

  FlightDetailsProvider({required this.flightRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FlightDetails? flightDetails;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
//need with dynamic with api
  // Future<ResponseModel> getFlightDetailsold(String flightId) async {
  //   _setLoading(true);
  //
  //   ApiResponse apiResponse = await flightRepo.getFlightDetails(flightId);
  //   ResponseModel responseModel;
  //
  //   if (apiResponse.response != null &&
  //       apiResponse.response?.statusCode == 200) {
  //     Map map = apiResponse.response?.data;
  //
  //     if (map['code'] != 200) {
  //       responseModel = ResponseModel(false, map['message']);
  //     } else {
  //       flightDetails =
  //           FlightDetails.fromJson(map['data']);
  //       responseModel = ResponseModel(true, map['message']);
  //     }
  //   } else {
  //     responseModel =
  //         ResponseModel(false, ApiErrorHandler.getMessage(apiResponse.error));
  //   }
  //
  //   _setLoading(false);
  //   return responseModel;
  // }

  Future<ResponseModel> getFlightDetails(String flightId) async {
    _setLoading(true);

    ApiResponse apiResponse = await flightRepo.getFlightDetails(flightId);
    ResponseModel responseModel;

    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {

      final Map<String, dynamic> map =
      apiResponse.response!.data as Map<String, dynamic>;

      flightDetails = FlightDetails.fromJson(map['flightDetails']);

      responseModel = ResponseModel(true, 'Flights loaded');
    } else {
      responseModel =
          ResponseModel(false, ApiErrorHandler.getMessage(apiResponse.error));
    }

    _setLoading(false);
    return responseModel;
  }

}
