import 'dart:io' as file;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/appwrite/appwrite_storage/appwrite_storage.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:uuid/v4.dart';
import '../../../utils/utils.dart';

class ProfileController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserId();
  }

  void getUserId(){
    final box = GetStorage();
    profileId = box.read('userId');
  }

  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Rx<String> name = ''.obs;
  Rx<String> email = ''.obs;
  String profileId = '';
  Rx<String> dateOfBirth = DateTime
      .now().toString()
      .obs;
  Rx<String> IU = ''.obs;
  Rx<String> phoneNumber = ''.obs;
  Rx<String> course = ''.obs;
  Rx<String> degree = ''.obs;
  Rx<int> year = 1.obs;
  Rx<int> sem = 1.obs;
  Rx<double> XMarks = 0.0.obs;
  Rx<String> XPassingYear = DateTime
      .now()
      .year
      .toString()
      .obs;
  Rx<double>? XIIMarks = 0.0.obs;
  Rx<String>? XIIPassingYear = ''.obs;
  Rx<String>? diplomaBranch = ''.obs;
  Rx<String>? diplomaPassingYear = ''.obs;
  Rx<double>? diplomaMarks = 0.0.obs;
  Rx<String> gender = ''.obs;
  Rx<String> board = ''.obs;
  Rx<String> engYearOfPassing = ''.obs;
  Rx<double> cgpa = 0.0.obs;
  Rx<int> activeBackLog = 0.obs;
  Rx<int> totalBackLog = 0.obs;
  Rx<String> address = ''.obs;
  Rx<String> linkedinProfile = ''.obs;
  Rx<String> githubProfile = ''.obs;
  Rx<String> otherLink = ''.obs;

  file.File? selectedPdf;
  Rx<String> selectedResumePath = ''.obs;

  Future<void> getResumePdf() async {
    selectedPdf = await Utils.pickPDF();
    selectedResumePath.value = selectedPdf!.path;
  }

  Rx<String> imagePath = ''.obs;

  void setImagePath(String path) {
    imagePath.value = path;
  }

  void generateRandomId() {
    profileId = UuidV4().generate();
  }

  Future<Document> createProfileAndUpload() async {
    try {
      //ToDo: Create profile with the above details!
      Profile profile = Profile(
          name: name.value,
          id: profileId,
          email: email.value,
          dateOfBirth: dateOfBirth.value,
          IU: IU.value,
          phoneNumber: phoneNumber.value,
          course: course.value,
          degree: degree.value,
          year: year.value,
          sem: sem.value,
          XMarks: XMarks.value,
          XPassingYear: XPassingYear.value,
          XIIPassingYear: XIIPassingYear!.value,
          XIIMarks: XIIMarks!.value,
          diplomaBranch: diplomaBranch!.value,
          diplomaMarks: diplomaMarks!.value,
          diplomaPassingYear: diplomaPassingYear!.value,
          gender: gender.value,
          board: board.value,
          engYearOfPassing: engYearOfPassing.value,
          cgpa: cgpa.value,
          activeBackLog: activeBackLog.value,
          totalBackLog: totalBackLog.value,
          address: address.value,
        linkedinProfile: linkedinProfile.value,
        githubProfile: githubProfile.value,
        otherLink: otherLink.value,
        appliedJobs: [],
        status: true,
      );
      final response = await AppWriteDb.uploadProfile(profile, profileId);
      return response;
    } on AppwriteException catch (e) {
      Get.showSnackbar(
          GetSnackBar(title: 'Error while creating profile', message: '$e',));
      rethrow;
    }
  }

  Future<File> uploadProfileImage() async {
    try {
      final response = await AppWriteStorage.uploadImage(
          imagePath.value, profileId);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading profile image: ${e}');
      rethrow;
    }
  }

  Future<File> uploadResume() async {
    try {
      final response = await AppWriteStorage.uploadResume(
          selectedResumePath.value, profileId, selectedPdf!.path);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading resume: ${e}');
      rethrow;
    }
  }
}