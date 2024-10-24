class UserModel {
  final String username;
  final String email;
  final String password;

  const UserModel({
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
