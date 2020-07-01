import 'package:truck/models/Quotation.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/Role.dart';

class User {
  final String userId;
  final String fullName;
  final String password;
  final int roleId;
  final Role role;

  final List<Request> requests;

  final List<Quotation> quotations;
  User({
    this.userId,
    this.fullName,
    this.password,
    this.roleId,
    this.role,
    this.requests,
    this.quotations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      password: json['password'],
      roleId: json['roleId'],
      role: Role.fromJson(json['role']),
      requests: json['requests'] != null
          ? List.from(json['requests'])
          : new List<Request>(),
      quotations: json['quotations'] != null
          ? List.from(json['quotations'])
          : new List<Quotation>(),
    );
  }
}
