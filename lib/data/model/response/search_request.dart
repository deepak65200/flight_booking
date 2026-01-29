class SearchRequest {
  final String origin;
  final String destination;
  final String departureDate;
  final String? returnDate;
  final int passengers;
  final String travelClass;
  final String tripType;

  SearchRequest({
    required this.origin,
    required this.destination,
    required this.departureDate,
    this.returnDate,
    required this.passengers,
    required this.travelClass,
    required this.tripType,
  });

  Map<String, dynamic> toJson() {
    return {
      "origin": origin,
      "destination": destination,
      "departureDate": departureDate,
      if (returnDate != null) "returnDate": returnDate,
      "passengers": passengers,
      "class": travelClass,
      "tripType": tripType,
    };
  }
}

