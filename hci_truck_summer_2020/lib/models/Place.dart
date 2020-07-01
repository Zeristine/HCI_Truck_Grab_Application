import 'dart:collection';

class Place {
  int id;
  String name;
  int addressId;

  Place({this.id, this.name, this.addressId});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json["placeId"],
      name: json["placeName"],
      addressId: json["addressId"],
    );
  }

  Map toJson() => {
        "placeId": id,
        "placeName": name,
        "addressId": addressId,
      };
}
