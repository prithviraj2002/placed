import 'dart:async';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/appwrite/appwrite_storage/appwrite_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';

import '../../../models/job_model.dart';

class HomeController extends GetxController {
  RxList<JobPost> jobPosts = <JobPost>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  String userId = '';
  RxList<String> appliedJobs = <String>[].obs;
  Rx<Profile> profile = Profile(
      name: 'name',
      id: 'id',
      email: 'email',
      dateOfBirth: 'dateOfBirth',
      IU: 'IU',
      phoneNumber: 'phoneNumber',
      course: '',
      degree: 'degree',
      year: 1,
      sem: 1,
      XMarks: 0.0,
      XPassingYear: 'XPassingYear',
      gender: 'gender',
      board: 'board',
      engYearOfPassing: 'engYearOfPassing',
      cgpa: 0.0,
      activeBackLog: 0,
      totalBackLog: 0,
      address: '',
      status: true).obs;
  Rx<Uint8List> profileImagePreview = Uint8List(0).obs;
  Rx<Uint8List> profileImage = Uint8List(0).obs;
  Rx<Uint8List> profileResumePreview = Uint8List(0).obs;
  Rx<File> profileResume = File($id: '', bucketId: '', $createdAt: '', $updatedAt: '', $permissions: [], name: '', signature: '', mimeType: '', sizeOriginal: 0, chunksTotal: 0, chunksUploaded: 0).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeUser();
    getAllJobs();
    listenToJobs();
  }

  Future<void> initializeUser() async {
    try {
      final box = GetStorage();
      userId = await box.read('userId');
      profile.value = await getProfileFromUserId(userId);
      profileImagePreview.value = await getProfileImagePreview();
      profileResumePreview.value = await getProfileResumePreview();
      profileResume.value = await AppWriteStorage.getResumeById(userId);
      profileImage.value = await AppWriteStorage.getImageView(userId);
    } on Exception catch (e) {
      print('An error occurred while getting user id in home controller!: $e');
    }
  }

  Future<Uint8List> getProfileImagePreview() async {
    final box = GetStorage();
    final String id = box.read('userId');
    try {
      final imagePreview = await AppWriteStorage.getImagePreviewById(id);
      return imagePreview;
    } on AppwriteException catch (e) {
      print(
          'An error occurred while getting profile image preview from home controller!: $e');
      rethrow;
    }
  }

  Future<Uint8List> getProfileResumePreview() async {
    final box = GetStorage();
    final String id = box.read('userId');
    try {
      final resumePreview = await AppWriteStorage.getResumePreview(id);
      return resumePreview;
    } on AppwriteException catch (e) {
      print(
          'An error occurred while getting profile resume preview from home controller!: $e');
      rethrow;
    }
  }

  Future<Profile> getProfileFromUserId(String id) async {
    try {
      final Profile profile = await AppWriteDb.getProfileById(id);
      return profile;
    } on Exception catch (e) {
      print(
          'An error occurred while getting profile from userid in home controller!: $e');
      rethrow;
    }
  }

  Future<void> getAllJobs() async {
    try {
      final response = await AppWriteDb.getJobPosts();
      for (Document job in response.documents) {
        print(job.data['title']);
        jobPosts.add(JobPost.fromJson(job.data, AppWriteStrings.dbID,));
      }
    } on AppwriteException catch (e) {
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
            jobPosts.add(JobPost.fromJson(event.payload, AppWriteStrings.dbID,));
          } else if (event.events.contains(
              "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.jobsCollectionId}.documents.*.create")) {
            getAllJobs();
          } else if (event.events.contains(
              "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.jobsCollectionId}.documents.*.delete")) {
            jobPosts.remove(JobPost.fromJson(event.payload, AppWriteStrings.dbID,));
          }
        });
  }

  void stopListeningToJobs() {
    subscription.cancel();
  }

  Future<Document> applyToAJob(String jobId) async {
    try {
      final response = await AppWriteDb.applyToJob(profile.value, jobId);
      appliedJobs.add(jobId);
      await AppWriteDb.addJobToProfile(appliedJobs);
      return response;
    } on AppwriteException catch (e) {
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
