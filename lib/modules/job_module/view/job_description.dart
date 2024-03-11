import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_applied.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

class JobDescription extends StatelessWidget {
  JobPost jobPost;
  JobDescription({required this.jobPost, super.key});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
        title: Text(
          'Job Details',
          style: GoogleFonts.poppins(
              fontSize: 24,
              color: PlacedColors.PrimaryBlack,
              fontWeight: FontWeight.w500),
        ),
        titleSpacing: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: homeController.appliedJobs.contains(jobPost.jobId) ? GradiantButton(
          onPressed: () {
            showDialog(context: context, builder: (ctx) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                title: Text('Applied already'),
                content: Text('You have already applied to this drive'),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text('Close'))
                ],
              );
            });
          },
          text: 'Applied',
        ) : GradiantButton(
          onPressed: () {
            homeController.applyToAJob(jobPost.jobId).then((value){
              if(value.$createdAt.isNotEmpty){
                showDialog(context: context, builder: (ctx) {
                  return AlertDialog(
                    title: Text('Applying to ${jobPost.companyName}'),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        CircularProgressIndicator()
                    ],
                  ),
                  );
                });
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => JobApplied(jobPost: jobPost,)));
                });
              }
              else if(value.$createdAt.isEmpty){
                showDialog(context: context, builder: (ctx) {
                  return AlertDialog(
                    title: Text('An error occurred!'),
                    content: Text('Kindly go back to home screen and try again'),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
                      }, child: Text('Go to Home'))
                    ],
                  );
                });
              }
            });
          },
          text: 'Apply Now',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Image widget
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/default_profile_image.png'),
                  // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 2. Text widget
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  jobPost.positionOffered,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7),
                // 3. Text widget
                Text(
                  jobPost.companyName,
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 37),
            // 4. Row of 4 custom containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(icon: 'assets/rupee.svg', text: 'Range', value: '${jobPost.package.first} - ${jobPost.package.last}',),
                CustomContainer(icon: 'assets/suitcase.svg', text: 'Job Type', value: 'Internship',),
                CustomContainer(icon: 'assets/location.svg', text: 'Location', value: '${jobPost.jobLocation}',),
                CustomContainer(icon: 'assets/calendar.svg', text: 'Last Date', value: '${jobPost.endDate.substring(0, 10)}',),
              ],
            ),
            SizedBox(height: 56),
            Text(
              'Job Description',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: PlacedColors.PrimaryBlack,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Text(
                jobPost.description ?? 'This is a default job Description',
                //vn skdvnskdmnskvkdvnskdvnsdlkvnskdvnkvnasdjnvsjodvnsjnvdjvnjldwcvnljsvnewjvndjkcnlknvslkdnvsljfvnlsjdvnsjvnjesonvojdvnljdvnsljfdvlsjvnsdvnlsjkdvnlsjkdvnsdljvnsvjndjvnsdjvnl
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: PlacedColors.PrimaryGrey2,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
            SizedBox(height: 20),
            // 7. Container
            Container(
              height: 100,
              color: PlacedColors.PrimaryWhite,
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/pdf_icon.svg',
                    height: 48,
                    width: 36,
                  ),
                  SizedBox(width: 8.0,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Campus Drive Nextnode Solu...PVT LTD',
                          style: GoogleFonts.poppins(fontSize: 12, color: PlacedColors.PrimaryBlack),
                        ),
                        Text(
                          '4.1 MB',
                          style: GoogleFonts.poppins(
                              fontSize: 8,
                              color: PlacedColors.PrimaryGrey2,
                              fontWeight: FontWeight.normal
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {

  final String icon;
  final String text;
  final String value;

  const CustomContainer({super.key, required this.icon, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 60,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            height: 14,
            width: 14,
          ),
          SizedBox(height: 1,),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: PlacedColors.PrimaryGrey3,
            ),
          ),
          SizedBox(height: 2,),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: PlacedColors.PrimaryBlack,
            ),
          ),
        ],
      ),
    );
  }
}
