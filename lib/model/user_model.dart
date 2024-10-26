class UserModel {
  final String username;
  final String email;
  final String password; // Add the password field

  const UserModel({
    required this.username,
    required this.email,
    required this.password, // Include in constructor
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password, // Include password
    };
  }

  // Convert JSON to UserModel
  static UserModel fromJson(Map<String, dynamic> data) {
    return UserModel(
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String, // Fetch password
    );
  }
}
