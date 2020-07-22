import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';

class Quotation {
  int quotationId;
  double price;
  String note;
  String driverId;
  int requestId;
  User driver;
  Request request;
  DateTime date;

  Quotation(
      {this.quotationId,
      this.price,
      this.note,
      this.driverId,
      this.requestId,
      this.driver,
      this.request,
      this.date});

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return Quotation(
        quotationId: json['quotationId'],
        price: json['price'],
        note: json['note'],
        requestId: json['requestId'],
        driverId: json['driverId'],
        date: DateTime.parse(json['date']),
        driver: User.fromJson(json['driver']),
        request: Request.fromJson(json['request']));
  }

  Map<String, dynamic> toJson() {
    return {
      'quotationId': quotationId,
      'price': price,
      'note': note,
      'requestId': requestId,
      'driverId': driverId,
      'date': date?.toIso8601String(),
    };
  }
}
