import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/resume_uploaded.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';
import '../../controller/profile_controller.dart';

class ResumeTab extends StatelessWidget {
  ProfileController controller;
  TabController tabController;
  ResumeTab({required this.controller, required this.tabController, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
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
          ),
          Obx(() => controller.selectedResumePath.isEmpty ? Container() : const Text('Resume selected Successfully!'))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GradiantButton(
          onPressed: () {
            if(tabController.index == 2){
              controller.selectedResumePath.isNotEmpty ?
              controller.createProfileAndUpload().then((value){
                if(value.$createdAt.isNotEmpty){
                  controller.uploadResume();
                  controller.uploadProfileImage();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Resume_Uploaded(controller: controller, tabController: tabController)));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred!')));
                }
              }) : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Resume has been selected!')));
            }else{
              tabController.animateTo((tabController.index + 1));
            }
          },
          text: 'Save & Continue',
        ),
      ),
    );
  }
}


