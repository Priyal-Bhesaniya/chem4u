class UserModel {
  String email;
  String password;
  String username;
  String mobile;  // Add mobile number field

  UserModel({
    required this.email,
    required this.password,
    required this.username,
    required this.mobile,  // Include mobile number in constructor
  });

  String? get id => null;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'mobileNumber': mobile,  // Add toJson method for mobile number
    };
  }
}
