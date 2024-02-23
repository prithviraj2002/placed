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
    print('Entered appwrite auth');
    try{
      final response = await account.create(
          email: email,
          password: password,
          userId: ID.unique(),
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
    print('User was signed in!');
    try{
      final response = await account.createEmailSession(
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

  static Future<void> anonymousSession() async{
    await account.createAnonymousSession();
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

  static Future<User> getUser() async{
    try{
      final User response = await account.get();
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while getting user email in appwrite auth: $e');
      rethrow;
    }
  }

}