import 'package:truck/models/Address.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';

class CommodityOwner {
  int commodityOwnerId;
  String fullName;
  String phoneNumber;
  bool isDefault;
  int addressId;
  String userId;
  Address address;
  User user;
  List<Request> requests;

  CommodityOwner(
      {this.commodityOwnerId,
      this.isDefault,
      this.userId,
      this.user,
      this.addressId,
      this.address,
      this.fullName,
      this.phoneNumber,
      this.requests});

  factory CommodityOwner.fromJson(Map<String, dynamic> json) {
    return CommodityOwner(
      commodityOwnerId: json['commodityOwnerId'],
      addressId: json['addressId'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
      address: Address.fromJson(json['address']),
      fullName: json['fullName'],
      isDefault: json['isDefault'],
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
        "userId": userId,
        "isDefault": isDefault,
        "phoneNumber": phoneNumber,
      };
}
