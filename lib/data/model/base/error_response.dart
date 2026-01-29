import 'dart:developer';

import 'package:flutter/foundation.dart';

class ErrorResponse {
  late List<Errors> _errors;

  List<Errors> get errors => _errors;

  ErrorResponse({required List<Errors> errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
      debugPrint('Error>>>>$json');
    if (json != null) {
      _errors = [];
      // json["errors"].forEach((v) {
      _errors.add(Errors.fromJson(json));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _errors.map((v) => v.toJson()).toList();
    return map;
  }
}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  late int _code;
  late String _message;
  late bool _loginSuccess;

  int get code => _code;
  String get message => _message;
  bool get loginSuccess => _loginSuccess;

  Errors({
    required int code,
    required String message,
    required bool loginSuccess,
  }) {
    _code = code;
    _message = message;
    _loginSuccess = loginSuccess;
  }

  Errors.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
    _loginSuccess = json["loginSuccess"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    map["loginSuccess"] = _loginSuccess;
    return map;
  }

}
