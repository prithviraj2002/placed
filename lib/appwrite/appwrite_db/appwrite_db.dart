import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';

class AppWriteDb{
  static Client client = Client().setEndpoint(AppWriteStrings.endPoint).setProject(AppWriteStrings.projectId);
  static Databases databases = Databases(client);

  static Future<Document> uploadProfile(Profile profile, String profileId) async{
    try{
      final response = await databases.createDocument(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.profileCollectionsId,
          documentId: profileId,
          data: profile.toMap()
      );
      return response;
    } on AppwriteException catch(e){
      print('An exception occurred while uploading Profile to database: $e');
      rethrow;
    }
  }
}