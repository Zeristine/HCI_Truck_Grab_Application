import 'package:flutter/foundation.dart';
import 'package:truck/models/Place.dart';

class Address {
  int addressId;
  List<Place> places;
  String streetName;

  Address({this.addressId, this.places, this.streetName});

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
            streetName: json["streetName"])
        : null;
  }
  Map toJson() => {
        "addressId": addressId,
        "streetName": streetName,
      };

  // List<Place> getPlaces(Map<String, dynamic> jsonPlaces) {
  //   List<Place> list = jsonPlaces.entries.map<Place>((entry) => Place(entry.key, entry.value)).toList();
  //   jsonPlaces.forEach((key, value) => places.add(Place(key, value)));
  // }
}
