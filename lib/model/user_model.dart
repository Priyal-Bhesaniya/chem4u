class UserModel {
  final String? id;
  final String? Username;
  final String? Password;
  final String? Email;


  const UserModel({
    this.id,
    this.Username,
    this.Password,
    this.Email,
  });

  toJoson(){
    return {
      'id': id,
      'username': Username,
      'password': Password,
      'email': Email,
    };
  }
}