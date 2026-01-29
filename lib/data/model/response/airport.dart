class AirportResponseModel {
  List<AirportModel>? airports;

  AirportResponseModel({this.airports});

  AirportResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['airports'] != null) {
      airports = <AirportModel>[];
      json['airports'].forEach((v) {
        airports!.add(AirportModel.fromJson(v));
      });
    }
  }
}

class AirportModel {
  int? id;
  String? code;
  String? name;
  String? city;
  String? country;
  String? timezone;

  AirportModel({
    this.id,
    this.code,
    this.name,
    this.city,
    this.country,
    this.timezone,
  });

  AirportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    city = json['city'];
    country = json['country'];
    timezone = json['timezone'];
  }
  String get displayName => '${city ?? ''} (${code ?? ''})';

  String get airportName => name ?? '';

  String get cityCountry => '${city ?? ''}, ${country ?? ''}';
}
