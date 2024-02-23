import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';

import '../../../models/job_model.dart';

class HomeController extends GetxController{

  RxList<JobPost> jobPosts = <JobPost>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  String userId = '';
  RxList<String> appliedJobs = <String>[].obs;
  Profile? profile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserId();
    getAllJobs();
    listenToJobs();
  }

  Future<void> getUserId() async{
    try{
      final box = GetStorage();
      userId = await box.read('userId');
      profile = await getProfileFromUserId(userId);
    } on Exception catch(e){
      print('An error occurred while getting user id in home controller!: $e');
    }
  }

  Future<Profile> getProfileFromUserId(String id) async{
    print('getting profile from user id in home controller!');
    try{
      final Profile profile = await AppWriteDb.getProfileById(id);
      print('Profile retrieved: ${profile.name}');
      return profile;
    } on Exception catch(e){
      print('An error occurred while getting profile from userid in home controller!: $e');
      rethrow;
    }
  }

  Future<void> getAllJobs() async{
    try{
      final response = await AppWriteDb.getJobPosts();
      for(Document job in response.documents){
        print(job.data['title']);
        jobPosts.add(JobPost.fromJson(job.data));
      }
    } on AppwriteException catch(e){
      print('An error occurred while getting all jobs!: $e');
      rethrow;
    }
  }

  void listenToJobs() {
    final realtime = Realtime(AppWriteDb.client);
    subscription = realtime
        .subscribe([
      "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.jobsCollectionId}.documents"
    ])
        .stream
        .listen((event) {
      if (event.events.contains(
          "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.jobsCollectionId}.documents.*.create")) {
        jobPosts.add(JobPost.fromJson(event.payload));
      } else if (event.events.contains(
          "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.jobsCollectionId}.documents.*.create")) {
        getAllJobs();
      }
      else if(event.events.contains("databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.jobsCollectionId}.documents.*.delete")){
        jobPosts.remove(JobPost.fromJson(event.payload));
      }
    });
  }

  void stopListeningToJobs(){
    subscription.cancel();
  }

  Future<Document> applyToAJob(String jobId) async{
    try{
      final response = await AppWriteDb.applyToJob(profile!, jobId);
      appliedJobs.add(jobId);
      await AppWriteDb.addJobToProfile(appliedJobs);
      return response;
    } on AppwriteException catch(e){
      print('An exception occurred while applying to a job!: $e');
      rethrow;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    stopListeningToJobs();
  }
}
