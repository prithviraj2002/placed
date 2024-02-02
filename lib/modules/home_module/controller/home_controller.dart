import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';

import '../../../models/job_model.dart';

class HomeController extends GetxController{

  RxList<JobPost> jobPosts = <JobPost>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllJobs();
    listenToJobs();
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

  Future<Document> applyToAJob(Profile profile, String jobId) async{
    try{
      final response = await AppWriteDb.applyToJob(profile, jobId);
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
