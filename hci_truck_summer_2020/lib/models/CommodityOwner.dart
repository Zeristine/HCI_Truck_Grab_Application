import 'package:truck/models/Address.dart';
import 'package:truck/models/Request.dart';

class CommodityOwner {
  int commodityOwnerId;
  String fullName;
  String phoneNumber;
  int addressId;
  Address address;
  List<Request> requests;

  CommodityOwner(
      {this.commodityOwnerId,
      this.addressId,
      this.address,
      this.fullName,
      this.phoneNumber,
      this.requests});

  factory CommodityOwner.fromJson(Map<String, dynamic> json) {
    return CommodityOwner(
      commodityOwnerId: json['commodityOwnerId'],
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
        "commodityOwnerId": commodityOwnerId,
        "fullName": fullName,
        "addressId": addressId,
        "phoneNumber": phoneNumber,
      };
}
