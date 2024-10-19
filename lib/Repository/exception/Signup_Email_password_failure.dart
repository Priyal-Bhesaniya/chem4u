class SignupEmailPasswordFailure implements Exception {
  final String message;

  // Constructor for the error with a specific message
  SignupEmailPasswordFailure([this.message = "An unknown error occurred."]);

  // Create a map of Firebase error codes to user-friendly messages
  factory SignupEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return SignupEmailPasswordFailure("The email address is not valid.");
      case 'user-disabled':
        return SignupEmailPasswordFailure("This user has been disabled.");
      case 'email-already-in-use':
        return SignupEmailPasswordFailure("The email is already in use.");
      case 'operation-not-allowed':
        return SignupEmailPasswordFailure("Email/password accounts are not enabled.");
      case 'weak-password':
        return SignupEmailPasswordFailure("The password is too weak.");
      default:
        return SignupEmailPasswordFailure();
    }
  }

  // Override toString method for easier debugging/logging
  @override
  String toString() => message;
}
