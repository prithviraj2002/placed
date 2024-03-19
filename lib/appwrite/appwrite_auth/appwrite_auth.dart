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
        print('An error occurred while logging out user!: $e');
      }
      rethrow;
    }
  }

  //To reset password of the user account in appwrite by confirming old password!
  static Future<User> resetPassword(String password, String oldPassword) async{
    try{
      final response = await account.updatePassword(
          password: password,
        oldPassword: oldPassword
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while reseting password in Appwrite Auth!: $e');
      rethrow;
    }
  }

  //Sends a recovery email to the provided email address.
  static Future<void> createRecovery(String email) async{
    print('Entering create recovery in appwriteauth');
    try{
      await account.createRecovery(email: email, url: 'http://localhost:51228/');
      print('Sending a recovery mail to $email');
    } on AppwriteException catch(e){
      print('An error occurred while creating recovery with $email!: $e');
    }
  }

  //Updates the password with the given email, temp reset code, password and password again.
  static Future<void> updatePassword(String email, String code, String password, String passwordAgain) async{
    final box = GetStorage();
    final String userId = box.read('userId');
    print('Entering updatePassword in appwriteauth');
    try{
      final response = await account.updateRecovery(
          userId: userId,
          secret: code,
          password: password,
          passwordAgain: passwordAgain
      );
      print('Here is the response of updateRecovery in updatePassword: ${response.secret}');
    } on AppwriteException catch(e){
      print('An error occurred while updating password with $email!: $e');
    }
  }

  static Future<User?> getUser() async{
    try{
      final User? response = await account.get();
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while getting user email in appwrite auth: $e');
      return null;
    }
  }

}