import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/controller/edit_profile_controller.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/utils/utils.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';
import 'package:url_launcher/url_launcher.dart';

class EditResumeTab extends StatefulWidget {
  EditProfileController controller;
  TabController tabController;
  Profile profile;

  EditResumeTab(
      {required this.controller, required this.tabController, required this.profile, super.key});

  @override
  State<EditResumeTab> createState() => _EditResumeTabState();
}

class _EditResumeTabState extends State<EditResumeTab> {

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                widget.controller.getResumePdf();
              },
              child: Container(
                //ToDo: Improve the container designer to match with the design in figma file.
                margin: EdgeInsets.fromLTRB(16, 16, 16, 140),
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
                        Text(homeController.profileResume.value.name),
                        const SizedBox(height: 20,),
                        Text('Tap to replace the resume')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(() =>
            widget.controller.selectedResumePath.isEmpty
                ? Container()
                : const Text('Resume selected Successfully!')),
            const SizedBox(height: 10,),
            OutlinedButton(onPressed: () {
              final uri = Uri.parse(Utils.getResumeUrl(homeController.userId));
              launchUrl(uri);
            }, child: const Text('View Uploaded Resume'))
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        child: GradiantButton(
          onPressed: () {
            if (widget.tabController.index == 2) {
              widget.controller.updateProfileAndUpload().then((value) {
                if (value.$createdAt.isNotEmpty) {
                  widget.controller.selectedResumePath.isNotEmpty ? widget
                      .controller.updateResume() : () {};
                  widget.controller.imagePath.isNotEmpty ? widget.controller
                      .updateProfileImage() : () {};
                  showDialog(context: context, builder: (ctx) {
                    return AlertDialog(
                      title: Text('Profile updated successfully!'),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (ctx) => Home()), (
                                  route) => false);
                        }, child: Text('Go back to home screen'))
                      ],
                    );
                  });
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('An error occurred!')));
                }
              });
            }
            else {
              widget.tabController.animateTo((widget.tabController.index + 1));
            }
          },
          text: 'Continue',
        ),
      ),
    );
  }
}
