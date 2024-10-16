class SignupEmailPasswordFailure {
   final String message;

const SignupEmailPasswordFailure([this.message = "An UnKnown error occure ."]);

factory SignupEmailPasswordFailure.code(String code){
  switch (code){
    case 'auth/email-already-in-use':
      return SignupEmailPasswordFailure("This email is already in use.");
    case 'auth/invalid-email':
      return SignupEmailPasswordFailure("Please enter a valid email address.");
    case 'auth/weak-password':
      return SignupEmailPasswordFailure("Password should be at least 6 characters long.");
    default:
      return SignupEmailPasswordFailure("An UnKnown error occure.");
  }
 
}

}