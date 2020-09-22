import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String type;
  String value;

  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    if (value.contains('http')) {
      this.type = 'http';
    } else if (value.contains('geo')) {
      this.type = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng getLatLng(){

    // geo:40.71226322834574,-74.0053404851807
    final latlon = value.substring(4).split(',');

    final latitud = double.parse(latlon[0]);
    final longitud = double.parse(latlon[1]);

    return new LatLng(latitud , longitud);
  }
}
