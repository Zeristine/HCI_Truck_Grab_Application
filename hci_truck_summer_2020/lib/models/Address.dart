import 'package:truck/models/Place.dart';

class Address {
  int addressId;
  List<Place> places;
  String streetName;
  String province;
  String district;
  String ward;

  Address(
      {this.addressId,
      this.places,
      this.streetName,
      this.province,
      this.district,
      this.ward});

  factory Address.fromJson(Map<String, dynamic> json) {
    List<Place> places = new List<Place>();
    if (json != null) {
      if (json['places'] != null) {
        var list = json['places'] as List;
        places = list.map((e) => Place.fromJson(e)).toList();
      }
    }
    return json != null
        ? Address(
            addressId: json["addressId"],
            places: places,
            province: json['province'],
            district: json['district'],
            ward: json['ward'],
            streetName: json["streetName"])
        : null;
  }
  Map toJson() => {
        "addressId": addressId,
        "streetName": streetName,
        "province": province,
        "district": district,
        "ward": ward,
      };

  // List<Place> getPlaces(Map<String, dynamic> jsonPlaces) {
  //   List<Place> list = jsonPlaces.entries.map<Place>((entry) => Place(entry.key, entry.value)).toList();
  //   jsonPlaces.forEach((key, value) => places.add(Place(key, value)));
  // }
}
