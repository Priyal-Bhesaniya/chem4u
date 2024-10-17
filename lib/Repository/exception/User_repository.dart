import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserRepository extends GetxController{
  static UserRepository get instance => Get.find( );
  final _db =FirebaseFirestore.instance;


 createUser(UserModel user)
{
  _db.collection("Users").add(user.toJoson());
}}
