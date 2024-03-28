import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isLoading = false;

  void toggleLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 330,
            width: 330,
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            decoration: BoxDecoration(
              border: Border.all(color: PlacedColors.PrimaryBlueLight1),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                color: PlacedColors.PrimaryWhite),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center widget wrapped in Expanded
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                          onTap: () {
                            if (widget.controller.selectedResumePath
                                .isEmpty) {
                            final uri = Uri.parse(
                            Utils.getResumeUrl(
                            homeController.userId));
                            launchUrl(uri);
                            }
                            },
                              child: SvgPicture.asset(
                                'assets/pdf_icon.svg',
                                height: 64,
                                width: 64,
                              ),
                            ),
                          SizedBox(height: 20),
                          Obx(() {
                            return Center(
                              child: Text(
                                widget.controller.selectedResumePath.isEmpty
                                    ? '${widget.profile.name} - Resume'
                                    : widget.controller.selectedResumePath.value,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: PlacedColors.PrimaryBlack,
                                    fontWeight: FontWeight.w400),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }),
                          Obx(() {
                            return TextButton(
                                onPressed: widget.controller.selectedResumePath
                                    .isNotEmpty? () {
                                  widget.controller.selectedResumePath.value =
                                  '';
                                } : null,
                                child: widget.controller.selectedResumePath
                                    .isNotEmpty
                                    ? Text('Clear Selection', style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: PlacedColors.PrimaryBlueMain),)
                                    : Text('')
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
                // TextButton at the bottom
                Container(
                  width: double.infinity,
                  // Make button width as wide as the screen
                  padding: EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () {
                      // Button onPressed callback
                      widget.controller.getResumePdf();
                    },
                    child: Text(
                      'Upload New',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: PlacedColors.PrimaryBlueMain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                toggleLoading();
                if (value.$createdAt.isNotEmpty) {
                  widget.controller.selectedResumePath.isNotEmpty ? widget
                      .controller.updateResume() : () {};
                  widget.controller.imagePath.isNotEmpty ? widget.controller
                      .updateProfileImage() : () {};
                  showDialog(context: context, builder: (ctx) {
                    toggleLoading();
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
                  toggleLoading();
                }
              });
            }
            else {
              widget.tabController.animateTo((widget.tabController.index + 1));
            }
          },
          widget: isLoading ? Center(child: CircularProgressIndicator(color: PlacedColors.PrimaryWhite,)) : Text('Continue', style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),),
        ),
      ),
    );
  }
}

// Obx(() {
// return Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisSize: MainAxisSize.max,
// children: [
// GestureDetector(
// onTap: () {
// widget.controller.getResumePdf();
// },
// child: Container(
// //ToDo: Improve the container designer to match with the design in figma file.
// margin: EdgeInsets.fromLTRB(16, 16, 16, 140),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(14.0)),
// color: PlacedColors.bgColor
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Icon(
// Icons.file_upload_outlined,
// size: 64,
// color: PlacedColors.textColor,
// ),
// SizedBox(height: 20),
// Column(
// children: [
// Text(homeController.profileResume.value.name),
// const SizedBox(height: 20,),
// Text('Tap to replace the resume')
// ],
// ),
// ],
// ),
// ),
// ),
// Obx(() =>
// widget.controller.selectedResumePath.isEmpty
// ? Container()
//     : const Text('Resume selected Successfully!')),
// const SizedBox(height: 10,),
// OutlinedButton(onPressed: () {
// final uri = Uri.parse(Utils.getResumeUrl(homeController.userId));
// launchUrl(uri);
// }, child: const Text('View Uploaded Resume'))
// ],
// );
// }),
