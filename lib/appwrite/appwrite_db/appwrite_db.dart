import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';

class AppWriteDb {
  static Client client = Client()
      .setEndpoint(AppWriteStrings.endPoint)
      .setProject(AppWriteStrings.projectId);
  static Databases databases = Databases(client);

  //To upload profile to appwrite database.
  static Future<Document> uploadProfile(Profile profile,
      String profileId) async {
    try {
      final response = await databases.createDocument(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.profileCollectionsId,
          documentId: profileId,
          data: profile.toMap()
      );
      return response;
    } on AppwriteException catch (e) {
      print('An exception occurred while uploading Profile to database: $e');
      rethrow;
    }
  }

  //To get profile from database using id
  static Future<Profile> getProfileById(String id) async {
    try {
      final response = await databases.getDocument(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.profileCollectionsId,
          documentId: id
      );
      return Profile.fromJson(response.data);
    } on AppwriteException catch (e) {
      print('An Exception occurred while gettingProfileById: $e');
      rethrow;
    }
  }

  //To get job openings
  static Future<DocumentList> getJobPosts() async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.jobsCollectionId);
      print(response.documents[0].data);
      return response;
    } on AppwriteException catch (e) {
      print('An exception occurred while loading job posts from database: $e');
      rethrow;
    }
  }

  //To apply to a job opening.
  static Future<Document> applyToJob(Profile profile, String jobId) async {
    try {
      final response = await databases.createDocument(
          databaseId: AppWriteStrings.dbID,
          collectionId: jobId,
          documentId: profile.id,
          data: profile.toMap()
      );
      return response;
    } on AppwriteException catch (e) {
      print('An exception occurred while applying to job post: $e');
      rethrow;
    }
  }
}