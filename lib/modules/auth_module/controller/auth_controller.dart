import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';

class AuthController extends GetxController{

  models.User? loggedInUser;

  static Future<User> signup(String email, String password) async{
    try{
      final response = await AppWriteAuth.signup(email, password);
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing up user!: $e');
      }
      rethrow;
    }
  }

  static Future<Session> login(String email, String password) async{
    try{
      final response = await AppWriteAuth.signin(email, password);
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing in user!: $e');
      }
      rethrow;
    }
  }

  static Future<dynamic> logout() async{
    try{
      final response = await AppWriteAuth.logout();
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing up user!: $e');
      }
      rethrow;
    }
  }
}