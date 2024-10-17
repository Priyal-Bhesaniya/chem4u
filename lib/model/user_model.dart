class UserModel {
  String email;
  String password;
  String username;
  String mobileNumber;  // Add mobile number field

  UserModel({
    required this.email,
    required this.password,
    required this.username,
    required this.mobileNumber,  // Include mobile number in constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'mobileNumber': mobileNumber,  // Add toJson method for mobile number
    };
  }
}
