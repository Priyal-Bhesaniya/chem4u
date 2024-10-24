class UserModel {
  final String username;
  final String email;

  // Removed the password field from the constructor and class
  const UserModel({
    required this.username,
    required this.email, required String password,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      // Exclude password for security reasons
    };
  }

  // Convert JSON to UserModel
  static UserModel fromJson(Map<String, dynamic> data) {
    return UserModel(
      username: data['username'] as String,
      email: data['email'] as String, password: '',
    );
  }
}
