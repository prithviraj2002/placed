import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';

class AppWriteAuth{
  static Client client = Client()
      .setEndpoint(AppWriteStrings.endPoint)
      .setProject(AppWriteStrings.projectId);

  static Account account = Account(client);

  static Future<User> signup(String email, String password) async{
    try{
      final response = account.create(
          email: email,
          password: password,
          userId: '',
      );
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing up user!: $e');
      }
      rethrow;
    }
  }

  static Future<Session> signin(String email, String password) async{
    try{
      final response = account.createEmailSession(
          email: email,
          password: password
      );
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing up user!: $e');
      }
      rethrow;
    }
  }

  static Future<dynamic> logout() async{
    try{
      final response = account.deleteSession(
        sessionId: 'current'
      );
      return response;
    } on AppwriteException catch(e){
      if (kDebugMode) {
        print('An error occurred while signing up user!: $e');
      }
      rethrow;
    }
  }

  static forgotPassword() async{
    try{

    } on AppwriteException catch(e){
      print('AN error occurred while forgot password!');
      rethrow;
    }
  }

}