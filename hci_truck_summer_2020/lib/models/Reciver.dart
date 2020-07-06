import 'package:truck/models/Address.dart';
import 'package:truck/models/Request.dart';

class Reciver {
  int reciverId;
  String fullName;
  String phoneNumber;
  int addressId;
  Address address;
  List<Request> requests;

  Reciver(
      {this.reciverId,
      this.addressId,
      this.address,
      this.fullName,
      this.phoneNumber,
      this.requests});

  factory Reciver.fromJson(Map<String, dynamic> json) {
    return Reciver(
      reciverId: json['reciverId'],
      addressId: json['addressId'],
      address: Address.fromJson(json['address']),
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      requests: json['requests'] != null
          ? List.from(json['requests'])
          : new List<Request>(),
    );
  }

  Map toJson() => {
        "commodityOwnerId": reciverId,
        "fullName": fullName,
        "addressId": addressId,
        "phoneNumber": phoneNumber,
      };
}
