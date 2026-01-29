import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//GLOBAL INTERNET STATUS MANAGER
class InternetStatusManager {
  static final InternetStatusManager _instance = InternetStatusManager._internal();
  factory InternetStatusManager() => _instance;
  InternetStatusManager._internal();

  final ValueNotifier<bool> isConnected = ValueNotifier<bool>(true);

  // Initialize internet monitoring
  void initialize() {
    _checkInitialConnection();
    _startMonitoring();
  }

  Future<void> _checkInitialConnection() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();
      bool isConnectedToNetwork = connectivityResults.any((result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);

      isConnected.value = isConnectedToNetwork;
    } catch (e) {
      isConnected.value = false;
    }
  }

  void _startMonitoring() {
    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _checkConnection();
    });

    // Optional: Periodically check connection (every 10 seconds)
    Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();
      bool isConnectedToNetwork = connectivityResults.any((result) =>
      result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet);

      isConnected.value = isConnectedToNetwork;
    } catch (e) {
      isConnected.value = false;
    }
  }

  // Manual check method for retry button
  Future<bool> checkConnection() async {
    await _checkConnection();
    return isConnected.value;
  }
}
