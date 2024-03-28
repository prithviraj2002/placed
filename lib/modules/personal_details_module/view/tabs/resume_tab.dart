import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/personal_details_module/view/tabs/resume_uploaded.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';
import '../../controller/profile_controller.dart';

class ResumeTab extends StatefulWidget {
  ProfileController controller;
  TabController tabController;

  ResumeTab({required this.controller, required this.tabController, super.key});

  @override
  State<ResumeTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeTab> {

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
        children: [
          Obx(() {
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              height: 330,
              width: 330,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  color: PlacedColors.PrimaryBlueLight1),
              child: GestureDetector(
                onTap: () {
                  if(widget.controller.selectedResumePath.isEmpty){
                    widget.controller.getResumePdf();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.controller.selectedResumePath.isEmpty ? Icon(
                      Icons.file_upload_outlined,
                      size: 64,
                      color: PlacedColors.textColor,
                    ) : SvgPicture.asset(
                        'assets/pdf_icon.svg',
                        height: 64,
                        width: 64,
                      ),
                    SizedBox(height: 20),
                    widget.controller.selectedResumePath.isEmpty ? Column(
                      children: [
                        Text(
                          'Upload your resume now to',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: PlacedColors.PrimaryBlueDark,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'seamlessly apply for jobs',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: PlacedColors.PrimaryBlueDark,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ) : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.controller.selectedResumePath.value,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: PlacedColors.PrimaryBlack,
                              fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                    widget.controller.selectedResumePath.isNotEmpty ? TextButton(
                        onPressed: () {
                          widget.controller.selectedResumePath.value = '';
                        },
                        child: Text('Clear Selection', style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: PlacedColors.PrimaryBlueMain),)
                    ) : Container(),
                    widget.controller.selectedResumePath.isNotEmpty ? Container(
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
                    ) : Container(),
                  ],
                ),
              ),
            );
          }),
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
              toggleLoading();
              showDialog(context: context, builder: (ctx) {
                return AlertDialog(
                  title: Text('Creating profile, taking you to drives!'),
                  content: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],),
                );
              });
              widget.controller.selectedResumePath.isNotEmpty ?
              widget.controller.createProfileAndUpload().then((value) {
                if (value.$createdAt.isNotEmpty) {
                  widget.controller.uploadResume();
                  widget.controller.uploadProfileImage();
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (ctx) => Home()), (
                      route) => false);
                  toggleLoading();
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('An error occurred!')));
                  toggleLoading();
                }
              }) : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('No Resume has been selected!')));
            } else {
              widget.tabController.animateTo((widget.tabController.index + 1));
            }
          },
          widget: isLoading ? SizedBox(height: 50, width: 50, child: Center(child: CircularProgressIndicator(color: PlacedColors.PrimaryWhite,))) : Text('Save & Continue', style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),),
        ),
      ),
    );
  }
}
