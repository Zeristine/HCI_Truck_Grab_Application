import 'package:truck/models/Request.dart';

class Status {
  int statusId;
  String value;
  int color;
  List<Request> requests;
  Status({this.statusId, this.value, this.color, this.requests});

  factory Status.fromJson(Map<String, dynamic> json) {
    List<Request> requests = List<Request>();
    if (json != null) {
      var list = json['requests'] as List;
      requests = list.map((e) => Request.fromJson(e)).toList();
    }
    return json != null
        ? Status(
            statusId: json['statusId'],
            value: json['value'],
            color: int.parse(json['color']),
            requests: requests,
          )
        : null;
  }
}
