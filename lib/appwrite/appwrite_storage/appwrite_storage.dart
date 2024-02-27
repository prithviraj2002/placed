import 'dart:typed_data';
import 'dart:io' as iofile;

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

  //Updates a profile image by deleting the previous file and creating another file with same id.
  static Future<dynamic> updateImage(String imagePath, String id) async {
    try {
      final response = await delImage(id).then((value){
        uploadImage(imagePath, id);
      });
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading image: $e');
      rethrow;
    }
  }

  //Deletes profile image with the given id from the image bucket file.
  static Future<dynamic> delImage(String id) async{
    try{
      final delResponse = await storage.deleteFile(
          bucketId: AppWriteStrings.imageBucketId,
          fileId: id
      );
      return delResponse;
    } on AppwriteException catch(e){
      print('An Exception occurred while deleting profile image: $e');
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

  static Future<Uint8List> getImagePreviewById(String id) async {
    try {
      final response = await storage.getFilePreview(
          bucketId: AppWriteStrings.imageBucketId, fileId: id);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while getting image preview by id: $e');
      rethrow;
    }
  }

  static Future<Uint8List> getImageView(String id) async{
    try {
      final response = await storage.getFileView(
          bucketId: AppWriteStrings.imageBucketId, fileId: id);
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while getting image preview by id: $e');
      rethrow;
    }
  }

  static Future<File> uploadResume(String resumePath, String id, String fileName) async {
    try {
      final response = await storage.createFile(
          bucketId: AppWriteStrings.resumeBucketId,
          fileId: id,
          file: InputFile.fromPath(path: resumePath, filename: fileName));
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading resume: $e');
      rethrow;
    }
  }

  //To update resume by deleting the resume of the given id first, then creating another resume file with the given id
  static Future<void> updateResume(String resumePath, String id, String fileName) async{
    try{
      final response = await delResume(id).then((value){
        uploadResume(resumePath, id, fileName);
      });
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while updating resume from appwrite storage!: $e');
    }
  }

  //To delete resume by id from resume bucket in storage.
  static Future<void> delResume(String id) async{
    try{
      final response = await storage.deleteFile(bucketId: AppWriteStrings.resumeBucketId, fileId: id);
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while deleting resume by id from Appwrite Storage!: $e');
    }
  }

  static Future<Uint8List> getResumePreview(String id) async{
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
      final File response = await storage.getFile(
          bucketId: AppWriteStrings.resumeBucketId,
          fileId: id
      );
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while getting resume by id: $e');
      rethrow;
    }
  }

  static Future<Uint8List> getResumeDownloadById(String id) async {
    try {
      final Uint8List response = await storage.getFileView(
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
