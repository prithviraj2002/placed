import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import '../../controller/profile_controller.dart';

class ResumeTab extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();
  ResumeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.getResumePdf();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 16,16,140),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          color: PlacedColors.bgColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              size: 64,
              color: PlacedColors.textColor,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Upload your resume now to',
                  style: TextStyle(
                      fontSize: 18,
                    color: PlacedColors.textColor
                  ),
                ),
                Text(
                  'seamlessly apply for jobs',
                  style: TextStyle(
                      fontSize: 18,
                      color: PlacedColors.textColor
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
