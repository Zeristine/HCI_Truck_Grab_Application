import 'package:truck/models/Address.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';

class Reciver {
  int reciverId;
  String fullName;
  String phoneNumber;
  bool isDefault;
  int addressId;
  String userId;
  Address address;
  User user;
  List<Request> requests;

  Reciver(
      {this.reciverId,
      this.isDefault,
      this.userId,
      this.user,
      this.addressId,
      this.address,
      this.fullName,
      this.phoneNumber,
      this.requests});

  factory Reciver.fromJson(Map<String, dynamic> json) {
    return Reciver(
      reciverId: json['reciverId'],
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
        "commodityOwnerId": reciverId,
        "fullName": fullName,
        "addressId": addressId,
        "userId": userId,
        "isDefault": isDefault,
        "phoneNumber": phoneNumber,
      };
}
