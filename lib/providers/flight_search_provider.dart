import 'dart:convert';
import 'package:flutter/material.dart';

import '../data/model/base/api_response.dart';
import '../data/model/base/response_model.dart';
import '../data/model/response/airport.dart';
import '../data/model/response/search_request.dart';
import '../data/repo/flight_repo.dart';
import '../data/remote/exception/apiErrorHandler.dart';
import '../helpers/common_helper.dart';

enum TripType { oneWay, roundTrip, multiCity }

class FlightSearchProvider extends ChangeNotifier {
  final FlightRepo flightRepo;

  FlightSearchProvider({required this.flightRepo});

  // ================= CONTROLLERS =================
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  // ================= AIRPORTS =================
  List<AirportModel> _airports = [];
  List<AirportModel> get airports => _airports;

  List<AirportModel> _filteredAirports = [];
  List<AirportModel> get filteredAirports => _filteredAirports;

  AirportModel? selectedOrigin;
  AirportModel? selectedDestination;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ================= TRIP =================
  TripType tripType = TripType.oneWay;
  DateTime? departureDate;
  DateTime? returnDate;

  bool get isRoundTrip => tripType == TripType.roundTrip;
  bool get isMultiCity => tripType == TripType.multiCity;

  void setDepartureDate(DateTime date) {
    departureDate = date;

    // Auto-fix return date if it became invalid
    if (returnDate != null && returnDate!.isBefore(date)) {
      returnDate = date;
    }

    notifyListeners();
  }


  void setReturnDate(DateTime date) {
    returnDate = date;
    notifyListeners();
  }


  // ================= TRAVELLER =================
  int travellers = 1;
  String travelClass = 'Eco/Prem. Eco';

  // ================= SPECIAL FARES =================
  bool isStudent = false;
  bool isSeniorCitizen = false;
  bool isArmedForces = false;

  // ================= ZERO CANCELLATION =================
  bool zeroCancellation = false;

  // ================= GETTERS =================
  String? get origin =>
      originController.text.trim().isEmpty ? null : originController.text.trim();

  String? get destination =>
      destinationController.text.trim().isEmpty
          ? null
          : destinationController.text.trim();

  // ================= AIRPORT ACTIONS =================
  void setOrigin(AirportModel airport) {
    selectedOrigin = airport;
    originController.text = '${airport.city} ${airport.code}';
    notifyListeners();
  }

  void setDestination(AirportModel airport) {
    selectedDestination = airport;
    destinationController.text = '${airport.city} ${airport.code}';
    notifyListeners();
  }

  void searchAirports(String query) {
    if (query.isEmpty) {
      _filteredAirports = List.from(_airports);
    } else {
      final q = query.toLowerCase();
      _filteredAirports = _airports.where((a) {
        return (a.city ?? '').toLowerCase().contains(q) ||
            (a.code ?? '').toLowerCase().contains(q) ||
            (a.name ?? '').toLowerCase().contains(q);
      }).toList();
    }
    notifyListeners();
  }

  // ================= LOAD AIRPORTS =================
  Future<ResponseModel> getAirports() async {
    _setLoading(true);

    final apiResponse = await flightRepo.getAirports();

    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      final Map<String, dynamic> map =
      apiResponse.response!.data as Map<String, dynamic>;

      final response = AirportResponseModel.fromJson(map);

      _airports
        ..clear()
        ..addAll(response.airports ?? []);

      _filteredAirports = List.from(_airports);

      _setLoading(false);
      return ResponseModel(true, 'Airports loaded');
    } else {
      _setLoading(false);
      return ResponseModel(
        false,
        ApiErrorHandler.getMessage(apiResponse.error),
      );
    }
  }

  // ================= VALIDATION =================
  bool get isValid {
    if (origin == null || departureDate == null) return false;
    if (!isMultiCity && destination == null) return false;
    if (isRoundTrip && returnDate == null) return false;
    return true;
  }

  bool validateAndShowError() {
    if (origin == null) {
      ToastUtils.showToast('Please select origin');
      return false;
    }
    if (!isMultiCity && destination == null) {
      ToastUtils.showToast('Please select destination');
      return false;
    }
    if (departureDate == null) {
      ToastUtils.showToast('Please select departure date');
      return false;
    }
    if (isRoundTrip && returnDate == null) {
      ToastUtils.showToast('Please select return date');
      return false;
    }
    return true;
  }

  // ================= ACTIONS =================
  void setTripType(TripType type) {
    tripType = type;
    if (type != TripType.roundTrip) returnDate = null;
    notifyListeners();
  }

  void toggleSpecialFare(String type) {
    if (type == 'student') isStudent = !isStudent;
    if (type == 'senior') isSeniorCitizen = !isSeniorCitizen;
    if (type == 'armed') isArmedForces = !isArmedForces;
    notifyListeners();
  }

  void toggleZeroCancellation() {
    zeroCancellation = !zeroCancellation;
    notifyListeners();
  }

  double swapTurns = 0.0;

  void swapLocations() {
    final temp = originController.text;
    originController.text = destinationController.text;
    destinationController.text = temp;
    swapTurns += 1.0;
    notifyListeners();
  }

  // ================= BUILD REQUEST =================
  SearchRequest buildSearchRequest() {
    return SearchRequest(
      origin: selectedOrigin?.code ?? origin!,
      destination: selectedDestination?.code ?? destination!,
      departureDate: departureDate!.toIso8601String(),
      returnDate: isRoundTrip ? returnDate?.toIso8601String() : null,
      passengers: travellers,
      travelClass: travelClass,
      tripType: tripType.name,
    );
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    super.dispose();
  }
}

