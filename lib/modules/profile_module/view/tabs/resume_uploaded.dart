import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';
import '../../controller/profile_controller.dart';

class Resume_Uploaded extends StatelessWidget {
  ProfileController controller;
  TabController tabController;

  Resume_Uploaded(
      {required this.controller, required this.tabController, super.key});

  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400,
            width: 400,
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                color: PlacedColors.bgColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/pdf_icon.svg',
                  height: 64,
                  width: 64,
                ),
                SizedBox(height: 20),
                Text(
                  'Resume Name',
                  style: TextStyle(fontSize: 18, color: PlacedColors.textColor),
                ),
              ],
            ),
          ),
          Obx(() => controller.selectedResumePath.isEmpty
              ? Container(
                  child: TextButton(
                    onPressed: () {
                      controller.getResumePdf();
                    },
                    child: Text(
                      'Upload New',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 18, color: PlacedColors.textColor),
                    ),
                  ),
                )
              : const Text('Resume selected Successfully!'))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GradiantButton(
          onPressed: () {
            if (tabController.index == 2) {
              controller.selectedResumePath.isNotEmpty
                  ? controller.createProfileAndUpload().then((value) {
                      if (value.$createdAt.isNotEmpty) {
                        controller.uploadResume();
                        controller.uploadProfileImage();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('An error occurred!')));
                      }
                    })
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('No Resume has been selected!')));
            } else {
              tabController.animateTo((tabController.index + 1));
            }
          },
          text: 'Save & Continue',
        ),
      ),
    );
  }
}
