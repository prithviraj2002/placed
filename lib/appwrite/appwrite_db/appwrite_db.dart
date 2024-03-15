import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/broadcast_message_model/broadcast_message.dart';
import 'package:placed_mobile_app/models/job_model.dart';
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

  //To update profile to appwrite database.
  static Future<Document> updateProfile(Profile profile,
      String profileId) async {
    try {
      final response = await databases.updateDocument(
        databaseId: AppWriteStrings.dbID,
        collectionId: AppWriteStrings.profileCollectionsId,
        documentId: profileId,
        data: profile.toMap(),
      );
      return response;
    } on AppwriteException catch (e) {
      print('An exception occurred while updating Profile to database: $e');
      rethrow;
    }
  }

  //To get profile from database using id
  static Future<Profile> getProfileById(String id) async {
    print('Getting profile from id in appwrite_db!');
    final box = GetStorage();
    final String userId = box.read('userId');
    try {
      final response = await databases.getDocument(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.profileCollectionsId,
          documentId: id
      );
      return Profile.fromJson(response.data, userId);
    } on AppwriteException catch (e) {
      print('An Exception occurred while gettingProfileById: $e');
      rethrow;
    }
  }

  //After applying to a job, that particular jobId should be added to profile's appliedJobs list in appwrite
  static Future<void> addJobToProfile(List<dynamic> appliedJobs) async {
    final box = GetStorage();
    final String userId = box.read('userId');
    try {
      await databases.updateDocument(databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.profileCollectionsId,
          documentId: userId,
          data: {
            'appliedJobs': appliedJobs
          }
      );
    } on AppwriteException catch (e) {
      print('An error occurred while adding job to profile!: $e');
    }
  }

  //To get job openings
  static Future<DocumentList> getJobPosts() async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.jobsCollectionId);
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

  static Future<JobPost> getJobById(String id) async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteStrings.dbID,
          collectionId: AppWriteStrings.jobsCollectionId,
          queries: [
            Query.equal('jobId', id)
          ]
      );
      return JobPost.fromJson(response.documents[0].data, response.documents[0].$id);
    } on AppwriteException catch (e) {
      print(
          'An error occurred while getting job post by id from appwrite_db!: $e');
      rethrow;
    }
  }

  //To get all broadcast messages
  static Future<List<BroadcastMessage>> getBroadcastMessages() async {
    List<BroadcastMessage> broadCastMessageList = [];
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteStrings.dbID, collectionId: AppWriteStrings.broadcastCollectionId
      );
      for(var msg in response.documents){
        broadCastMessageList.add(BroadcastMessage.fromJson(msg.data));
      }
      return broadCastMessageList;
    } on AppwriteException catch (e) {
      print(
          'An error occurred while getting broadcast message from id in appwrite db!: $e');
      rethrow;
    }
  }
}