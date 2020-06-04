class User {
  String id;
  String username;
  String email;
  String password;

  User(this.id, this.username, this.email, this.password);

  toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
    };
  }
}
