import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';

class AuthController extends GetxController{

  models.User? loggedInUser;

   Future<User> signup(String email, String password) async{
    print('Entered authcontroller');
    try{
      final response = await AppWriteAuth.signup(email, password);
      final box = GetStorage();
      box.write('userId', response.$id);
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing up user!: $e');
      }
      rethrow;
    }
  }

  Future<Session> login(String email, String password) async{
    try{
      final response = await AppWriteAuth.signin(email, password);
      final box = GetStorage();
      box.write('userId', response.userId);
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing in user!: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> logout() async{
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

  Future<void> createRecovery(String email) async{
    print('Entered createRecovery in auth_controller!');
    await AppWriteAuth.createRecovery(email);
  }

  Future<void> updatePassword(String email, String code, String password, String passwordAgain) async{
    print('Entered updatePassword in auth_controller!');
    await AppWriteAuth.updatePassword(email, code, password, passwordAgain);
  }
}