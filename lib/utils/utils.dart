import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class Utils{
  static Future<String> chooseImage(String src) async{
    ImagePicker picker = ImagePicker();
    if(src == 'camera'){
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      if(image!.path.isNotEmpty){
        return image.path;
      }
      else{
        return '';
      }
    }
    if(src == 'gallery'){
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if(image!.path.isNotEmpty){
        return image.path;
      }
      else{
        return '';
      }
    }
    else{
      return '';
    }
  }

  static Future<File?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}