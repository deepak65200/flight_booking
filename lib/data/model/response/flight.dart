class FlightSearchResponseModel {
  List<FlightModel>? flights;
  SearchCriteriaModel? searchCriteria;
  FilterModel? filters;

  FlightSearchResponseModel({
    this.flights,
    this.searchCriteria,
    this.filters,
  });

  FlightSearchResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['flights'] != null) {
      flights = [];
      json['flights'].forEach((v) {
        flights!.add(FlightModel.fromJson(v));
      });
    }
    searchCriteria = json['searchCriteria'] != null
        ? SearchCriteriaModel.fromJson(json['searchCriteria'])
        : null;
    filters =
    json['filters'] != null ? FilterModel.fromJson(json['filters']) : null;
  }
}

/* ================= FLIGHT ================= */

class FlightModel {
  String? id;
  AirlineModel? airline;
  AirportModel? origin;
  AirportModel? destination;
  ScheduleModel? departure;
  ScheduleModel? arrival;
  String? duration;
  int? stops;
  List<StopDetailModel>? stopDetails;
  String? travelClass;
  PriceModel? price;
  SeatModel? seats;
  BaggageModel? baggage;
  CancellationModel? cancellation;
  List<String>? amenities;
  double? rating;

  FlightModel({
    this.id,
    this.airline,
    this.origin,
    this.destination,
    this.departure,
    this.arrival,
    this.duration,
    this.stops,
    this.stopDetails,
    this.travelClass,
    this.price,
    this.seats,
    this.baggage,
    this.cancellation,
    this.amenities,
    this.rating,
  });

  FlightModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    airline =
    json['airline'] != null ? AirlineModel.fromJson(json['airline']) : null;
    origin =
    json['origin'] != null ? AirportModel.fromJson(json['origin']) : null;
    destination = json['destination'] != null
        ? AirportModel.fromJson(json['destination'])
        : null;
    departure = json['departure'] != null
        ? ScheduleModel.fromJson(json['departure'])
        : null;
    arrival = json['arrival'] != null
        ? ScheduleModel.fromJson(json['arrival'])
        : null;
    duration = json['duration'];
    stops = json['stops'];
    if (json['stopDetails'] != null) {
      stopDetails = [];
      json['stopDetails'].forEach((v) {
        stopDetails!.add(StopDetailModel.fromJson(v));
      });
    }
    travelClass = json['class'];
    price =
    json['price'] != null ? PriceModel.fromJson(json['price']) : null;
    seats =
    json['seats'] != null ? SeatModel.fromJson(json['seats']) : null;
    baggage =
    json['baggage'] != null ? BaggageModel.fromJson(json['baggage']) : null;
    cancellation = json['cancellation'] != null
        ? CancellationModel.fromJson(json['cancellation'])
        : null;
    amenities = json['amenities']?.cast<String>();
    rating = (json['rating'] as num?)?.toDouble();


  }
  String get airlineName => airline?.name ?? '--';

  String get airlineCode => airline?.code ?? '--';

  String get departureTime => departure?.time ?? '--:--';

  String get arrivalTime => arrival?.time ?? '--:--';

  String get departureCode => origin?.code ?? '--';

  String get arrivalCode => destination?.code ?? '--';

  int get totalPrice => price?.total ?? 0;

  bool get isRefundable => cancellation?.allowed ?? false;

  String get cabinClass => travelClass ?? '--';

}

/* ================= AIRLINE ================= */

class AirlineModel {
  String? code;
  String? name;
  String? logo;

  AirlineModel({this.code, this.name, this.logo});

  AirlineModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    logo = json['logo'];
  }
}

/* ================= AIRPORT ================= */

class AirportModel {
  String? code;
  String? city;
  String? airport;
  String? terminal;

  AirportModel({this.code, this.city, this.airport, this.terminal});

  AirportModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    city = json['city'];
    airport = json['airport'];
    terminal = json['terminal'];
  }
}

/* ================= SCHEDULE ================= */

class ScheduleModel {
  String? time;
  String? date;

  ScheduleModel({this.time, this.date});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    date = json['date'];
  }
}

/* ================= STOP DETAILS ================= */

class StopDetailModel {
  String? airport;
  String? code;
  String? duration;

  StopDetailModel({this.airport, this.code, this.duration});

  StopDetailModel.fromJson(Map<String, dynamic> json) {
    airport = json['airport'];
    code = json['code'];
    duration = json['duration'];
  }
}

/* ================= PRICE ================= */

class PriceModel {
  int? base;
  int? taxes;
  int? total;
  String? currency;

  PriceModel({this.base, this.taxes, this.total, this.currency});

  PriceModel.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    taxes = json['taxes'];
    total = json['total'];
    currency = json['currency'];
  }
}

/* ================= SEATS ================= */

class SeatModel {
  int? available;
  int? total;

  SeatModel({this.available, this.total});

  SeatModel.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    total = json['total'];
  }
}

/* ================= BAGGAGE ================= */

class BaggageModel {
  String? cabin;
  String? checkin;

  BaggageModel({this.cabin, this.checkin});

  BaggageModel.fromJson(Map<String, dynamic> json) {
    cabin = json['cabin'];
    checkin = json['checkin'];
  }
}

/* ================= CANCELLATION ================= */

class CancellationModel {
  bool? allowed;
  int? fee;
  String? beforeDeparture;

  CancellationModel({this.allowed, this.fee, this.beforeDeparture});

  CancellationModel.fromJson(Map<String, dynamic> json) {
    allowed = json['allowed'];
    fee = json['fee'];
    beforeDeparture = json['beforeDeparture'];
  }
}

/* ================= SEARCH CRITERIA ================= */

class SearchCriteriaModel {
  String? origin;
  String? destination;
  String? departureDate;
  String? returnDate;
  int? passengers;
  String? travelClass;
  String? tripType;

  SearchCriteriaModel({
    this.origin,
    this.destination,
    this.departureDate,
    this.returnDate,
    this.passengers,
    this.travelClass,
    this.tripType,
  });

  SearchCriteriaModel.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    destination = json['destination'];
    departureDate = json['departureDate'];
    returnDate = json['returnDate'];
    passengers = json['passengers'];
    travelClass = json['class'];
    tripType = json['tripType'];
  }
}

/* ================= FILTERS ================= */

class FilterModel {
  PriceRangeModel? priceRange;
  List<String>? airlines;
  List<int>? stops;
  List<DepartureTimeSlotModel>? departureTimeSlots;

  FilterModel({
    this.priceRange,
    this.airlines,
    this.stops,
    this.departureTimeSlots,
  });

  FilterModel.fromJson(Map<String, dynamic> json) {
    priceRange = json['priceRange'] != null
        ? PriceRangeModel.fromJson(json['priceRange'])
        : null;
    airlines = json['airlines']?.cast<String>();
    stops = json['stops']?.cast<int>();
    if (json['departureTimeSlots'] != null) {
      departureTimeSlots = [];
      json['departureTimeSlots'].forEach((v) {
        departureTimeSlots!.add(DepartureTimeSlotModel.fromJson(v));
      });
    }
  }
}

class PriceRangeModel {
  int? min;
  int? max;

  PriceRangeModel({this.min, this.max});

  PriceRangeModel.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }
}

class DepartureTimeSlotModel {
  String? label;
  String? range;
  int? count;

  DepartureTimeSlotModel({this.label, this.range, this.count});

  DepartureTimeSlotModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    range = json['range'];
    count = json['count'];
  }
}
