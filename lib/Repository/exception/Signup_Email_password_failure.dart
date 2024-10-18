class SignupEmailPasswordFailure {
  final String message;

  const SignupEmailPasswordFailure([this.message = "An unknown error occurred."]);

  factory SignupEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'auth/email-already-in-use':
        return SignupEmailPasswordFailure("This email is already in use.");
      case 'auth/invalid-email':
        return SignupEmailPasswordFailure("Please enter a valid email address.");
      case 'auth/weak-password':
        return SignupEmailPasswordFailure("Password should be at least 6 characters long.");
      case 'auth/mobile-number-not-verified': // Another possible case
        return SignupEmailPasswordFailure("Your mobile number could not be verified. Please check and try again.");
      // Add more specific error codes here if needed
      default:
        return SignupEmailPasswordFailure("An unknown error occurred.");
    }
  }
}
