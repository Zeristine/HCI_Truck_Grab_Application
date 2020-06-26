import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';

class Quotation {
  int quotationId;
  double price;
  String note;
  User driver;
  Request request;
  DateTime date;

  Quotation(
      {this.quotationId, this.price, this.note, this.driver, this.request, this.date});

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return Quotation(
        quotationId: json['quotationId'],
        price: json['price'],
        note: json['note'],
        date: json['date'],
        driver: User.fromJson(json['driver']),
        request: Request.fromJson(json['request']));
  }
}
