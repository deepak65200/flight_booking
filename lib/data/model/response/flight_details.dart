class FlightDetails {
  String? id;
  String? bookingId;
  String? status;
  Airline? airline;
  Aircraft? aircraft;
  Itinerary? itinerary;
  Fare? fare;
  Baggage? baggage;
  Cancellation? cancellation;
  Amenities? amenities;
  SeatMap? seatMap;
  CheckinInfo? checkinInfo;
  List<String>? importantInfo;
  Terms? terms;
  Ratings? ratings;
  List<PopularAddons>? popularAddons;
  List<AlternativeFlights>? alternativeFlights;

  FlightDetails(
      {this.id,
        this.bookingId,
        this.status,
        this.airline,
        this.aircraft,
        this.itinerary,
        this.fare,
        this.baggage,
        this.cancellation,
        this.amenities,
        this.seatMap,
        this.checkinInfo,
        this.importantInfo,
        this.terms,
        this.ratings,
        this.popularAddons,
        this.alternativeFlights});

  FlightDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    status = json['status'];
    airline =
    json['airline'] != null ?  Airline.fromJson(json['airline']) : null;
    aircraft = json['aircraft'] != null
        ?  Aircraft.fromJson(json['aircraft'])
        : null;
    itinerary = json['itinerary'] != null
        ?  Itinerary.fromJson(json['itinerary'])
        : null;
    fare = json['fare'] != null ?  Fare.fromJson(json['fare']) : null;
    baggage =
    json['baggage'] != null ?  Baggage.fromJson(json['baggage']) : null;
    cancellation = json['cancellation'] != null
        ?  Cancellation.fromJson(json['cancellation'])
        : null;
    amenities = json['amenities'] != null
        ?  Amenities.fromJson(json['amenities'])
        : null;
    seatMap =
    json['seatMap'] != null ?  SeatMap.fromJson(json['seatMap']) : null;
    checkinInfo = json['checkinInfo'] != null
        ?  CheckinInfo.fromJson(json['checkinInfo'])
        : null;
    importantInfo = json['importantInfo'].cast<String>();
    terms = json['terms'] != null ?  Terms.fromJson(json['terms']) : null;
    ratings =
    json['ratings'] != null ?  Ratings.fromJson(json['ratings']) : null;
    if (json['popularAddons'] != null) {
      popularAddons = <PopularAddons>[];
      json['popularAddons'].forEach((v) {
        popularAddons!.add( PopularAddons.fromJson(v));
      });
    }
    if (json['alternativeFlights'] != null) {
      alternativeFlights = <AlternativeFlights>[];
      json['alternativeFlights'].forEach((v) {
        alternativeFlights!.add( AlternativeFlights.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['status'] = status;
    if (airline != null) {
      data['airline'] = airline!.toJson();
    }
    if (aircraft != null) {
      data['aircraft'] = aircraft!.toJson();
    }
    if (itinerary != null) {
      data['itinerary'] = itinerary!.toJson();
    }
    if (fare != null) {
      data['fare'] = fare!.toJson();
    }
    if (baggage != null) {
      data['baggage'] = baggage!.toJson();
    }
    if (cancellation != null) {
      data['cancellation'] = cancellation!.toJson();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.toJson();
    }
    if (seatMap != null) {
      data['seatMap'] = seatMap!.toJson();
    }
    if (checkinInfo != null) {
      data['checkinInfo'] = checkinInfo!.toJson();
    }
    data['importantInfo'] = importantInfo;
    if (terms != null) {
      data['terms'] = terms!.toJson();
    }
    if (ratings != null) {
      data['ratings'] = ratings!.toJson();
    }
    if (popularAddons != null) {
      data['popularAddons'] =
          popularAddons!.map((v) => v.toJson()).toList();
    }
    if (alternativeFlights != null) {
      data['alternativeFlights'] =
          alternativeFlights!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Airline {
  String? code;
  String? name;
  String? logo;
  String? contact;
  String? website;

  Airline({this.code, this.name, this.logo, this.contact, this.website});

  Airline.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    logo = json['logo'];
    contact = json['contact'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['logo'] = logo;
    data['contact'] = contact;
    data['website'] = website;
    return data;
  }
}

class Aircraft {
  String? model;
  String? registration;
  int? capacity;
  String? configuration;

  Aircraft({this.model, this.registration, this.capacity, this.configuration});

  Aircraft.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    registration = json['registration'];
    capacity = json['capacity'];
    configuration = json['configuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['model'] = model;
    data['registration'] = registration;
    data['capacity'] = capacity;
    data['configuration'] = configuration;
    return data;
  }
}

class Itinerary {
  List<Segments>? segments;
  String? totalDuration;
  int? stops;
  String? totalDistance;

  Itinerary(
      {this.segments, this.totalDuration, this.stops, this.totalDistance});

  Itinerary.fromJson(Map<String, dynamic> json) {
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) {
        segments!.add( Segments.fromJson(v));
      });
    }
    totalDuration = json['totalDuration'];
    stops = json['stops'];
    totalDistance = json['totalDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (segments != null) {
      data['segments'] = segments!.map((v) => v.toJson()).toList();
    }
    data['totalDuration'] = totalDuration;
    data['stops'] = stops;
    data['totalDistance'] = totalDistance;
    return data;
  }
}

class Segments {
  int? segmentId;
  String? flightNumber;
  Origin? origin;
  Origin? destination;
  Departure? departure;
  Departure? arrival;
  String? duration;
  String? distance;
  String? operatingAirline;
  String? cabinClass;
  String? bookingClass;

  Segments(
      {this.segmentId,
        this.flightNumber,
        this.origin,
        this.destination,
        this.departure,
        this.arrival,
        this.duration,
        this.distance,
        this.operatingAirline,
        this.cabinClass,
        this.bookingClass});

  Segments.fromJson(Map<String, dynamic> json) {
    segmentId = json['segmentId'];
    flightNumber = json['flightNumber'];
    origin =
    json['origin'] != null ?  Origin.fromJson(json['origin']) : null;
    destination = json['destination'] != null
        ?  Origin.fromJson(json['destination'])
        : null;
    departure = json['departure'] != null
        ?  Departure.fromJson(json['departure'])
        : null;
    arrival = json['arrival'] != null
        ?  Departure.fromJson(json['arrival'])
        : null;
    duration = json['duration'];
    distance = json['distance'];
    operatingAirline = json['operatingAirline'];
    cabinClass = json['cabinClass'];
    bookingClass = json['bookingClass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['segmentId'] = segmentId;
    data['flightNumber'] = flightNumber;
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (departure != null) {
      data['departure'] = departure!.toJson();
    }
    if (arrival != null) {
      data['arrival'] = arrival!.toJson();
    }
    data['duration'] = duration;
    data['distance'] = distance;
    data['operatingAirline'] = operatingAirline;
    data['cabinClass'] = cabinClass;
    data['bookingClass'] = bookingClass;
    return data;
  }
}

class Origin {
  String? code;
  String? name;
  String? city;
  String? terminal;
  String? gate;

  Origin({this.code, this.name, this.city, this.terminal, this.gate});

  Origin.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    city = json['city'];
    terminal = json['terminal'];
    gate = json['gate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['city'] = city;
    data['terminal'] = terminal;
    data['gate'] = gate;
    return data;
  }
}

class Departure {
  String? scheduledTime;
  String? date;
  String? timezone;
  String? localDateTime;

  Departure({this.scheduledTime, this.date, this.timezone, this.localDateTime});

  Departure.fromJson(Map<String, dynamic> json) {
    scheduledTime = json['scheduledTime'];
    date = json['date'];
    timezone = json['timezone'];
    localDateTime = json['localDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['scheduledTime'] = scheduledTime;
    data['date'] = date;
    data['timezone'] = timezone;
    data['localDateTime'] = localDateTime;
    return data;
  }
}

class Fare {
  Breakdown? breakdown;
  String? currency;
  int? perPassenger;
  List<Passengers>? passengers;
  List<String>? paymentOptions;

  Fare(
      {this.breakdown,
        this.currency,
        this.perPassenger,
        this.passengers,
        this.paymentOptions});

  Fare.fromJson(Map<String, dynamic> json) {
    breakdown = json['breakdown'] != null
        ?  Breakdown.fromJson(json['breakdown'])
        : null;
    currency = json['currency'];
    perPassenger = json['perPassenger'];
    if (json['passengers'] != null) {
      passengers = <Passengers>[];
      json['passengers'].forEach((v) {
        passengers!.add( Passengers.fromJson(v));
      });
    }
    paymentOptions = json['paymentOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (breakdown != null) {
      data['breakdown'] = breakdown!.toJson();
    }
    data['currency'] = currency;
    data['perPassenger'] = perPassenger;
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    data['paymentOptions'] = paymentOptions;
    return data;
  }
}

class Breakdown {
  int? baseFare;
  int? fuelSurcharge;
  int? airportTax;
  int? passengerServiceFee;
  int? gst;
  int? total;

  Breakdown(
      {this.baseFare,
        this.fuelSurcharge,
        this.airportTax,
        this.passengerServiceFee,
        this.gst,
        this.total});

  Breakdown.fromJson(Map<String, dynamic> json) {
    baseFare = json['baseFare'];
    fuelSurcharge = json['fuelSurcharge'];
    airportTax = json['airportTax'];
    passengerServiceFee = json['passengerServiceFee'];
    gst = json['gst'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['baseFare'] = baseFare;
    data['fuelSurcharge'] = fuelSurcharge;
    data['airportTax'] = airportTax;
    data['passengerServiceFee'] = passengerServiceFee;
    data['gst'] = gst;
    data['total'] = total;
    return data;
  }
}

class Passengers {
  String? type;
  int? count;
  int? farePerPassenger;

  Passengers({this.type, this.count, this.farePerPassenger});

  Passengers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    count = json['count'];
    farePerPassenger = json['farePerPassenger'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['type'] = type;
    data['count'] = count;
    data['farePerPassenger'] = farePerPassenger;
    return data;
  }
}

class Baggage {
  Cabin? cabin;
  Checkin? checkin;
  SpecialItems? specialItems;

  Baggage({this.cabin, this.checkin, this.specialItems});

  Baggage.fromJson(Map<String, dynamic> json) {
    cabin = json['cabin'] != null ?  Cabin.fromJson(json['cabin']) : null;
    checkin =
    json['checkin'] != null ?  Checkin.fromJson(json['checkin']) : null;
    specialItems = json['specialItems'] != null
        ?  SpecialItems.fromJson(json['specialItems'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (cabin != null) {
      data['cabin'] = cabin!.toJson();
    }
    if (checkin != null) {
      data['checkin'] = checkin!.toJson();
    }
    if (specialItems != null) {
      data['specialItems'] = specialItems!.toJson();
    }
    return data;
  }
}

class Cabin {
  String? allowance;
  String? dimensions;
  int? pieces;
  String? notes;

  Cabin({this.allowance, this.dimensions, this.pieces, this.notes});

  Cabin.fromJson(Map<String, dynamic> json) {
    allowance = json['allowance'];
    dimensions = json['dimensions'];
    pieces = json['pieces'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['allowance'] = allowance;
    data['dimensions'] = dimensions;
    data['pieces'] = pieces;
    data['notes'] = notes;
    return data;
  }
}

class Checkin {
  String? allowance;
  int? pieces;
  int? additionalBaggagePrice;
  String? additionalBaggageIncrement;
  String? maxWeight;

  Checkin(
      {this.allowance,
        this.pieces,
        this.additionalBaggagePrice,
        this.additionalBaggageIncrement,
        this.maxWeight});

  Checkin.fromJson(Map<String, dynamic> json) {
    allowance = json['allowance'];
    pieces = json['pieces'];
    additionalBaggagePrice = json['additionalBaggagePrice'];
    additionalBaggageIncrement = json['additionalBaggageIncrement'];
    maxWeight = json['maxWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['allowance'] = allowance;
    data['pieces'] = pieces;
    data['additionalBaggagePrice'] = additionalBaggagePrice;
    data['additionalBaggageIncrement'] = additionalBaggageIncrement;
    data['maxWeight'] = maxWeight;
    return data;
  }
}

class SpecialItems {
  String? sportingEquipment;
  String? musicalInstruments;
  String? medicalEquipment;

  SpecialItems(
      {this.sportingEquipment, this.musicalInstruments, this.medicalEquipment});

  SpecialItems.fromJson(Map<String, dynamic> json) {
    sportingEquipment = json['sportingEquipment'];
    musicalInstruments = json['musicalInstruments'];
    medicalEquipment = json['medicalEquipment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['sportingEquipment'] = sportingEquipment;
    data['musicalInstruments'] = musicalInstruments;
    data['medicalEquipment'] = medicalEquipment;
    return data;
  }
}

class Cancellation {
  Policy? policy;
  DateChange? dateChange;

  Cancellation({this.policy, this.dateChange});

  Cancellation.fromJson(Map<String, dynamic> json) {
    policy =
    json['policy'] != null ?  Policy.fromJson(json['policy']) : null;
    dateChange = json['dateChange'] != null
        ?  DateChange.fromJson(json['dateChange'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (policy != null) {
      data['policy'] = policy!.toJson();
    }
    if (dateChange != null) {
      data['dateChange'] = dateChange!.toJson();
    }
    return data;
  }
}

class Policy {
  bool? allowed;
  bool? refundable;
  List<Conditions>? conditions;
  NoShow? noShow;

  Policy({this.allowed, this.refundable, this.conditions, this.noShow});

  Policy.fromJson(Map<String, dynamic> json) {
    allowed = json['allowed'];
    refundable = json['refundable'];
    if (json['conditions'] != null) {
      conditions = <Conditions>[];
      json['conditions'].forEach((v) {
        conditions!.add( Conditions.fromJson(v));
      });
    }
    noShow =
    json['noShow'] != null ?  NoShow.fromJson(json['noShow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['allowed'] = allowed;
    data['refundable'] = refundable;
    if (conditions != null) {
      data['conditions'] = conditions!.map((v) => v.toJson()).toList();
    }
    if (noShow != null) {
      data['noShow'] = noShow!.toJson();
    }
    return data;
  }
}

class Conditions {
  String? timeBeforeDeparture;
  int? cancellationFee;
  int? refundPercentage;

  Conditions(
      {this.timeBeforeDeparture, this.cancellationFee, this.refundPercentage});

  Conditions.fromJson(Map<String, dynamic> json) {
    timeBeforeDeparture = json['timeBeforeDeparture'];
    cancellationFee = json['cancellationFee'];
    refundPercentage = json['refundPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['timeBeforeDeparture'] = timeBeforeDeparture;
    data['cancellationFee'] = cancellationFee;
    data['refundPercentage'] = refundPercentage;
    return data;
  }
}

class NoShow {
  bool? refund;
  String? note;

  NoShow({this.refund, this.note});

  NoShow.fromJson(Map<String, dynamic> json) {
    refund = json['refund'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['refund'] = refund;
    data['note'] = note;
    return data;
  }
}

class DateChange {
  bool? allowed;
  int? fee;
  String? fareDifference;
  String? conditions;

  DateChange({this.allowed, this.fee, this.fareDifference, this.conditions});

  DateChange.fromJson(Map<String, dynamic> json) {
    allowed = json['allowed'];
    fee = json['fee'];
    fareDifference = json['fareDifference'];
    conditions = json['conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['allowed'] = allowed;
    data['fee'] = fee;
    data['fareDifference'] = fareDifference;
    data['conditions'] = conditions;
    return data;
  }
}

class Amenities {
  List<Inflight>? inflight;
  List<GroundServices>? groundServices;
  List<Accessibility>? accessibility;

  Amenities({this.inflight, this.groundServices, this.accessibility});

  Amenities.fromJson(Map<String, dynamic> json) {
    if (json['inflight'] != null) {
      inflight = <Inflight>[];
      json['inflight'].forEach((v) {
        inflight!.add( Inflight.fromJson(v));
      });
    }
    if (json['groundServices'] != null) {
      groundServices = <GroundServices>[];
      json['groundServices'].forEach((v) {
        groundServices!.add( GroundServices.fromJson(v));
      });
    }
    if (json['accessibility'] != null) {
      accessibility = <Accessibility>[];
      json['accessibility'].forEach((v) {
        accessibility!.add( Accessibility.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (inflight != null) {
      data['inflight'] = inflight!.map((v) => v.toJson()).toList();
    }
    if (groundServices != null) {
      data['groundServices'] =
          groundServices!.map((v) => v.toJson()).toList();
    }
    if (accessibility != null) {
      data['accessibility'] =
          accessibility!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inflight {
  String? name;
  bool? available;
  bool? free;
  int? price;
  String? description;

  Inflight(
      {this.name, this.available, this.free, this.price, this.description});

  Inflight.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    available = json['available'];
    free = json['free'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['available'] = available;
    data['free'] = free;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}

class GroundServices {
  String? name;
  bool? available;
  String? timing;

  GroundServices({this.name, this.available, this.timing});

  GroundServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    available = json['available'];
    timing = json['timing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['available'] = available;
    data['timing'] = timing;
    return data;
  }
}

class Accessibility {
  String? name;
  bool? available;
  String? notes;

  Accessibility({this.name, this.available, this.notes});

  Accessibility.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    available = json['available'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['available'] = available;
    data['notes'] = notes;
    return data;
  }
}

class SeatMap {
  bool? available;
  String? layout;
  int? rows;
  List<SeatTypes>? seatTypes;
  Occupancy? occupancy;

  SeatMap(
      {this.available, this.layout, this.rows, this.seatTypes, this.occupancy});

  SeatMap.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    layout = json['layout'];
    rows = json['rows'];
    if (json['seatTypes'] != null) {
      seatTypes = <SeatTypes>[];
      json['seatTypes'].forEach((v) {
        seatTypes!.add( SeatTypes.fromJson(v));
      });
    }
    occupancy = json['occupancy'] != null
        ?  Occupancy.fromJson(json['occupancy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['available'] = available;
    data['layout'] = layout;
    data['rows'] = rows;
    if (seatTypes != null) {
      data['seatTypes'] = seatTypes!.map((v) => v.toJson()).toList();
    }
    if (occupancy != null) {
      data['occupancy'] = occupancy!.toJson();
    }
    return data;
  }
}

class SeatTypes {
  String? type;
  int? price;
  String? rows;

  SeatTypes({this.type, this.price, this.rows});

  SeatTypes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
    rows = json['rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    data['rows'] = rows;
    return data;
  }
}

class Occupancy {
  int? available;
  int? booked;
  int? total;

  Occupancy({this.available, this.booked, this.total});

  Occupancy.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    booked = json['booked'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['available'] = available;
    data['booked'] = booked;
    data['total'] = total;
    return data;
  }
}

class CheckinInfo {
  WebCheckin? webCheckin;
  AirportCheckin? airportCheckin;
  BoardingPass? boardingPass;

  CheckinInfo({this.webCheckin, this.airportCheckin, this.boardingPass});

  CheckinInfo.fromJson(Map<String, dynamic> json) {
    webCheckin = json['webCheckin'] != null
        ?  WebCheckin.fromJson(json['webCheckin'])
        : null;
    airportCheckin = json['airportCheckin'] != null
        ?  AirportCheckin.fromJson(json['airportCheckin'])
        : null;
    boardingPass = json['boardingPass'] != null
        ?  BoardingPass.fromJson(json['boardingPass'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (webCheckin != null) {
      data['webCheckin'] = webCheckin!.toJson();
    }
    if (airportCheckin != null) {
      data['airportCheckin'] = airportCheckin!.toJson();
    }
    if (boardingPass != null) {
      data['boardingPass'] = boardingPass!.toJson();
    }
    return data;
  }
}

class WebCheckin {
  String? opens;
  String? closes;
  String? url;

  WebCheckin({this.opens, this.closes, this.url});

  WebCheckin.fromJson(Map<String, dynamic> json) {
    opens = json['opens'];
    closes = json['closes'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['opens'] = opens;
    data['closes'] = closes;
    data['url'] = url;
    return data;
  }
}

class AirportCheckin {
  String? opens;
  String? closes;
  String? counters;

  AirportCheckin({this.opens, this.closes, this.counters});

  AirportCheckin.fromJson(Map<String, dynamic> json) {
    opens = json['opens'];
    closes = json['closes'];
    counters = json['counters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['opens'] = opens;
    data['closes'] = closes;
    data['counters'] = counters;
    return data;
  }
}

class BoardingPass {
  List<String>? format;
  String? required;

  BoardingPass({this.format, this.required});

  BoardingPass.fromJson(Map<String, dynamic> json) {
    format = json['format'].cast<String>();
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['format'] = format;
    data['required'] = required;
    return data;
  }
}

class Terms {
  String? fareRules;
  String? baggagePolicy;
  String? agePolicy;
  String? identificationRequirements;

  Terms(
      {this.fareRules,
        this.baggagePolicy,
        this.agePolicy,
        this.identificationRequirements});

  Terms.fromJson(Map<String, dynamic> json) {
    fareRules = json['fareRules'];
    baggagePolicy = json['baggagePolicy'];
    agePolicy = json['agePolicy'];
    identificationRequirements = json['identificationRequirements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['fareRules'] = fareRules;
    data['baggagePolicy'] = baggagePolicy;
    data['agePolicy'] = agePolicy;
    data['identificationRequirements'] = identificationRequirements;
    return data;
  }
}

class Ratings {
  double? overall;
  double? punctuality;
  String? service;
  double? comfort;
  double? valueForMoney;
  int? totalReviews;

  Ratings(
      {this.overall,
        this.punctuality,
        this.service,
        this.comfort,
        this.valueForMoney,
        this.totalReviews});

  Ratings.fromJson(Map<String, dynamic> json) {
    overall = json['overall'];
    punctuality = json['punctuality'];
    service = json['service']?.toString();
    comfort = json['comfort'];
    valueForMoney = json['valueForMoney'];
    totalReviews = json['totalReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['overall'] = overall;
    data['punctuality'] = punctuality;
    data['service'] = service;
    data['comfort'] = comfort;
    data['valueForMoney'] = valueForMoney;
    data['totalReviews'] = totalReviews;
    return data;
  }
}

class PopularAddons {
  String? id;
  String? name;
  String? description;
  int? price;
  bool? recommended;

  PopularAddons(
      {this.id, this.name, this.description, this.price, this.recommended});

  PopularAddons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['recommended'] = recommended;
    return data;
  }
}

class AlternativeFlights {
  String? id;
  String? airline;
  String? departure;
  String? arrival;
  int? price;
  int? priceDifference;

  AlternativeFlights(
      {this.id,
        this.airline,
        this.departure,
        this.arrival,
        this.price,
        this.priceDifference});

  AlternativeFlights.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    airline = json['airline'];
    departure = json['departure'];
    arrival = json['arrival'];
    price = json['price'];
    priceDifference = json['priceDifference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['airline'] = airline;
    data['departure'] = departure;
    data['arrival'] = arrival;
    data['price'] = price;
    data['priceDifference'] = priceDifference;
    return data;
  }
}













