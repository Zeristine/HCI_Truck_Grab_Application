import 'package:truck/models/Quotation.dart';
import 'package:truck/models/user.dart';

class Request {
  int requestId;
  String commodityName;
  double weight;
  DateTime dateCreate;
  DateTime validDate;
  String status;
  User user;
  List<Quotation> quotations;

  Request({this.requestId, this.commodityName, this.weight, this.dateCreate,
      this.validDate, this.status, this.user, this.quotations});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        requestId: json['requestId'],
        commodityName: json['commodityName'],
        weight: json['weight'],
        dateCreate: json['dateCreate'],
        validDate: json['validDate'],
        status: json['status'],
        user: User.fromJson(json['user']),
        quotations: List.from(json['quotations']));
  }
}
