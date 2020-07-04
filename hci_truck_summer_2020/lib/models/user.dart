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
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      imagePath: json['imagePath'],
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

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'password': password,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'imagePath': imagePath,
        'roleId': roleId,
        'role': role,
        'requests': requests,
        'quotations': quotations,
      };
}
