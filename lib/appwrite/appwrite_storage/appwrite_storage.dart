import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';

class AppWriteStorage {
  static Client client = Client()
      .setProject(AppWriteStrings.projectId)
      .setEndpoint(AppWriteStrings.endPoint);

  static Storage storage = Storage(client);

  static Future<File> uploadImage(String imagePath, String id) async {
    try {
      final response = await storage.createFile(
          bucketId: AppWriteStrings.imageBucketId,
          fileId: id,
          file: InputFile.fromPath(path: imagePath, filename: 'user-image'));
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading image: $e');
      rethrow;
    }
  }

  static Future<File> getImageById(String id) async {
    try {
      final response = await storage.getFile(
          bucketId: AppWriteStrings.imageBucketId, fileId: id);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while getting image by id: $e');
      rethrow;
    }
  }

  static Future<File> uploadResume(String resumePath, String id) async {
    try {
      final response = await storage.createFile(
          bucketId: AppWriteStrings.resumeBucketId,
          fileId: id,
          file: InputFile.fromPath(path: resumePath, filename: 'user-resume'));
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading resume: $e');
      rethrow;
    }
  }

  Future<Uint8List> getResumePreview(String id) async{
    try{
      final response = await storage.getFilePreview(bucketId: AppWriteStrings.resumeBucketId, fileId: id);
      return response;
    } on AppwriteException catch(e){
      print('An Exception occurred while getting resume preview: $e');
      rethrow;
    }
  }

  static Future<File> getResumeById(String id) async {
    try {
      final response = storage.getFile(
          bucketId: AppWriteStrings.resumeBucketId,
          fileId: id
      );
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while getting resume by id: $e');
      rethrow;
    }
  }
}
