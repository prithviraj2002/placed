import 'dart:io' as file;

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/appwrite/appwrite_storage/appwrite_storage.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/utils/utils.dart';

class EditProfileController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getUserId();
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

  Future<void> getProfile() async{
    final box = GetStorage();
    final String userId = box.read('userId');
    try{
      final Profile profile = await AppWriteDb.getProfileById(userId);
      name.value = profile.name;
      email.value = profile.email;
      dateOfBirth.value = profile.dateOfBirth;
      IU.value = profile.IU;
      phoneNumber.value = profile.phoneNumber;
      course.value = profile.course;
      degree.value = profile.degree;
      year.value = profile.year;
      sem.value = profile.sem;
      XMarks.value = profile.XMarks;
      XPassingYear.value = profile.XPassingYear;
      XIIMarks!.value = profile.XIIMarks!;
      XIIPassingYear!.value = profile.XIIPassingYear!;
      diplomaBranch!.value = profile.diplomaBranch!;
      diplomaPassingYear!.value = profile.diplomaPassingYear!;
      diplomaMarks!.value = profile.diplomaMarks!;
      gender.value = profile.gender;
      board.value = profile.board;
      engYearOfPassing.value = profile.engYearOfPassing;
      cgpa.value = profile.cgpa;
      activeBackLog.value = profile.activeBackLog;
      totalBackLog.value = profile.totalBackLog;
      address.value = profile.address;
      linkedinProfile.value = profile.linkedinProfile!;
      githubProfile.value = profile.githubProfile!;
      otherLink.value = profile.otherLink!;
    } on AppwriteException catch(e){
      print('An error occurred while getting profile in edit profile controller!: $e');
    }
  }

  Future<Document> updateProfileAndUpload() async {
    final box = GetStorage();
    final String userId = box.read('userId');
    try {
      //ToDo: Create profile with the above details!
      Profile profile = Profile(
        name: name.value,
        id: userId,
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
        status: true,
      );
      final response = await AppWriteDb.updateProfile(profile, userId);
      return response;
    } on AppwriteException catch (e) {
      Get.showSnackbar(
          GetSnackBar(title: 'Error while updating profile', message: '$e',));
      rethrow;
    }
  }

  Future<dynamic> updateProfileImage() async {
    final box = GetStorage();
    final String userId = box.read('userId');
    try {
      final response = await AppWriteStorage.updateImage(
          imagePath.value, userId);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading profile image: ${e}');
      rethrow;
    }
  }

  Future<void> updateResume() async {
    final box = GetStorage();
    final String userId = box.read('userId');
    try {
      final response = await AppWriteStorage.updateResume(
          selectedResumePath.value, userId, selectedPdf!.path);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading resume: ${e}');
      rethrow;
    }
  }
}