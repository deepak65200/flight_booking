import 'package:flight_booking_app/data/model/response/flight.dart';
import 'package:flutter/material.dart';
import '../data/model/base/response_model.dart';
import '../data/model/response/search_request.dart';
import '../data/remote/exception/apiErrorHandler.dart';
import '../data/repo/flight_repo.dart';

class FlightResultsProvider extends ChangeNotifier {
  final FlightRepo flightRepo;

  FlightResultsProvider({required this.flightRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SearchCriteriaModel? searchParams;

  final List<FlightModel> _allFlights = [];
  List<FlightModel> _visibleFlights = [];
  List<FlightModel> get flightList => _visibleFlights;

  bool nonStopOnly = false;

  bool get hasActiveFilters => nonStopOnly;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// needed with dynamic api
  // Future<ResponseModel> searchFlights(SearchRequest request) async {
  //   _setLoading(true);
  //
  //   ApiResponse apiResponse = await flightRepo.searchFlights(request);
  //   ResponseModel responseModel;
  //
  //   if (apiResponse.response != null &&
  //       apiResponse.response?.statusCode == 200) {
  //     Map map = apiResponse.response?.data;
  //
  //     if (map['code'] != 200) {
  //       responseModel = ResponseModel(false, map['message']);
  //     } else {
  //       _flightList.clear();
  //       map['data'].forEach((e) {
  //         _flightList.add(Flight.fromJson(e));
  //       });
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

  Future<ResponseModel> searchFlights(SearchRequest request) async {
    _setLoading(true);

    final apiResponse = await flightRepo.searchFlights(request);

    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      final Map<String, dynamic> map =
      apiResponse.response!.data as Map<String, dynamic>;

      final response =
      FlightSearchResponseModel.fromJson(map);

      searchParams = response.searchCriteria;

      _allFlights
        ..clear()
        ..addAll(response.flights ?? []);

      _applyFilters();

      _setLoading(false);
      return ResponseModel(true, 'Flights loaded');
    } else {
      _setLoading(false);
      return ResponseModel(
        false,
        ApiErrorHandler.getMessage(apiResponse.error),
      );
    }
  }

  void _applyFilters() {
    _visibleFlights = List.from(_allFlights);

    if (nonStopOnly) {
      _visibleFlights =
          _visibleFlights.where((f) => f.stops == 0).toList();
    }

    notifyListeners();
  }

  void clearFilters() {
    nonStopOnly = false;
    _applyFilters();
  }

  void setNonStop(bool value) {
    nonStopOnly = value;
    _applyFilters();
  }

  void sortByPrice({required bool ascending}) {
    _visibleFlights.sort((a, b) =>
    ascending
        ? a.totalPrice.compareTo(b.totalPrice)
        : b.totalPrice.compareTo(a.totalPrice));
    notifyListeners();
  }

  void sortByDuration() {
    _visibleFlights.sort(
          (a, b) => _durationToMinutes(a.duration)
          .compareTo(_durationToMinutes(b.duration)),
    );
    notifyListeners();
  }

  void sortByDeparture() {
    _visibleFlights.sort((a, b) =>
        (a.departure?.time ?? '')
            .compareTo(b.departure?.time ?? ''));
    notifyListeners();
  }

  int _durationToMinutes(String? duration) {
    if (duration == null) return 0;
    final h =
    RegExp(r'(\d+)h').firstMatch(duration)?.group(1);
    final m =
    RegExp(r'(\d+)m').firstMatch(duration)?.group(1);
    return (int.tryParse(h ?? '0')! * 60) +
        int.tryParse(m ?? '0')!;
  }
}




