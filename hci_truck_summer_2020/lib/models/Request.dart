import 'dart:collection';

import 'package:truck/models/CommodityOwner.dart';
import 'package:truck/models/Quotation.dart';
import 'package:truck/models/Reciver.dart';
import 'package:truck/models/Status.dart';
import 'package:truck/models/user.dart';

class Request {
  int requestId;
  String commodityName;
  int commodityOwnerId;
  int reciverId;
  double weight;
  DateTime dateCreate;
  DateTime validDate;
  int statusId;
  Status status;
  String note;
  String userId;
  User user;
  List<Quotation> quotations;
  CommodityOwner commodityOwner;
  Reciver reciver;

  Request({
    this.requestId,
    this.commodityName,
    this.commodityOwnerId,
    this.reciverId,
    this.weight,
    this.dateCreate,
    this.validDate,
    this.statusId,
    this.note,
    this.userId,
    this.user,
    this.quotations,
    this.reciver,
    this.commodityOwner,
    this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    List<Quotation> quotations = new List<Quotation>();
    if (json != null) {
      if (json['quotations'] != null && json['quotations'] != []) {
        var list = json['quotations'] as List;
        if (list.length > 0) {
          quotations = list.map((e) => Quotation.fromJson(e)).toList();
        }
      }
    }
    return json != null
        ? Request(
            requestId: json['requestId'],
            commodityName: json['commodityName'],
            commodityOwnerId: json['commodityOwnerId'],
            reciverId: json['reciverId'],
            weight: json['weight'],
            dateCreate: DateTime.parse(json['dateCreate']),
            validDate: DateTime.parse(json['validDate']),
            statusId: json['statusId'],
            status: Status.fromJson(json['status']),
            note: json['note'],
            userId: json['userId'],
            user: json['user'] != null ? User.fromJson(json['user']) : null,
            quotations: quotations,
            reciver: json['reciver'] != null
                ? Reciver.fromJson(json['reciver'])
                : null,
            commodityOwner: json['commodityOwner'] != null
                ? CommodityOwner.fromJson(json['commodityOwner'])
                : null,
          )
        : null;
  }

  Map toJson() => {
        "requestId": requestId,
        "commodityName": commodityName,
        "commodityOwnerId": commodityOwnerId,
        "reciverId": reciverId,
        "weight": weight,
        "dateCreate": dateCreate.toIso8601String(),
        "validDate": validDate.toIso8601String(),
        "statusId": statusId,
        "note": note,
        "userId": userId,
      };
}
