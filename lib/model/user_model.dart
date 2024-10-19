class UserModel {

 final String?id;
 final String?username;
 final String?email;
 final String? password;



  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.username,
  });

 
toJson(){
  return {
    'id': id,
    'username': username,
    'email': email,
    'password': password,
  };
}
}
