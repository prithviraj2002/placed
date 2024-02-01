import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';

class AppWriteAuth{
  static Client client = Client()
      .setEndpoint(AppWriteStrings.endPoint)
      .setProject(AppWriteStrings.projectId);

  static Account account = Account(client);

  static Future<Session> signup(String email, String password) async{
    try{
      final response = account.createEmailSession(
          email: email,
          password: password
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while signing up user!: $e');
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
      print('An error occurred while signing up user!: $e');
      rethrow;
    }
  }

  static Future<dynamic> logout(String email, String password) async{
    try{
      final response = account.deleteSession(
        sessionId: 'current'
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while signing up user!: $e');
      rethrow;
    }
  }

}