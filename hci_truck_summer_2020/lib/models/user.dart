import 'package:truck/models/Quotation.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/Role.dart';

class User {
  final String userId;
  final String fullName;
  final String password;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;
  final String imagePath;
  final int roleId;
  final Role role;

  final List<Request> requests;

  final List<Quotation> quotations;
  User({
    this.userId,
    this.fullName,
    this.password,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.imagePath,
    this.roleId,
    this.role,
    this.requests,
    this.quotations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<Quotation> quotations = new List<Quotation>();
    if (json != null) {
      if (json['quotations'] != null) {
        var list = json['quotations'] as List;
        quotations = list.map((e) => Quotation.fromJson(e)).toList();
      }
    }
    return json != null
        ? User(
            userId: json['userId'],
            fullName: json['fullName'],
            password: json['password'],
            phoneNumber: json['phoneNumber'],
            gender: json['gender'],
            dateOfBirth: json['dateOfBirth'],
            imagePath: json['imagePath'],
            roleId: json['roleId'],
            role: json['role'] != null ? Role.fromJson(json['role']) : null,
            requests: json['requests'] != null
                ? List.from(json['requests'])
                : new List<Request>(),
            quotations: quotations,
          )
        : null;
  }
}
