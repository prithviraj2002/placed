import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';

class AuthController extends GetxController{

  models.User? loggedInUser;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  static Future<User> signup(String email, String password) async{
    try{
      final response = await AppWriteAuth.signup(email, password);
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while signing up user!: $e');
      rethrow;
    }
  }
}