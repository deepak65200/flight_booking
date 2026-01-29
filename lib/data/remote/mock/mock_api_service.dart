import 'dart:convert';
import 'package:flutter/services.dart';

class MockApiService {
  Future<Map<String, dynamic>> getAirports() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final data = await rootBundle.loadString('assets/json/airports.json');
    return json.decode(data);
  }

  Future<Map<String, dynamic>> searchFlights() async {
    await Future.delayed(const Duration(seconds: 1));
    final data = await rootBundle.loadString('assets/json/flights.json');
    return json.decode(data);
  }

  Future<Map<String, dynamic>> getFlightDetails() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final data =
    await rootBundle.loadString('assets/json/flight_details.json');
    return json.decode(data);
  }
}
