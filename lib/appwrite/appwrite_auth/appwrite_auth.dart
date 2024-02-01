import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';

class AppWriteAuth{
  static Client client = Client()
      .setEndpoint(AppWriteStrings.endPoint)
      .setProject(AppWriteStrings.projectId);

  static Account account = Account(client);

  static Future<User> signup(String email, String password) async{
    try{
      final response = account.create(
          userId: ID.unique(),
          email: email,
          password: password
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while signing up user!: $e');
      rethrow;
    }
  }

}