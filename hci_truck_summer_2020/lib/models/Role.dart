import 'package:truck/models/user.dart';

class Role {
  int roleId;
  String roleName;
  List<User> users;

  Role({this.roleId, this.roleName, this.users});

  factory Role.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return Role(
        roleId: json['roleId'],
        roleName: json['roleName'],
        users:
            json['users'] != null ? List.from(json['users']) : new List<User>(),
      );
    }
  }
}
