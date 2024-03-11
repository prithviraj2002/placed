import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/constants/placed_dimensions.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/job_module/view/viewAll.dart';
import 'package:placed_mobile_app/widgets/custom_card_mydrive.dart';
import 'package:placed_mobile_app/widgets/custom_card_upcomingdrive.dart';

class HomeTab extends StatelessWidget {
  HomeController homeController;

  HomeTab({required this.homeController, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text(
            'Upcoming Drives',
            style: TextStyle(
              fontSize: PlacedDimens.heading_text,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Obx(
          () {
            return homeController.jobPosts.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UpcomingDriveCard(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Drives',
                              style: TextStyle(
                                fontSize: PlacedDimens.heading_text,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            homeController.appliedJobs.isNotEmpty ?
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewAll(appliedJobs: homeController.appliedJobs,)));
                                },
                                child: Text(
                                  'View all',
                                  style: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        PlacedColors.PrimaryBlueMain,
                                    color: PlacedColors.PrimaryBlueMain,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )) : Container(),
                          ],
                        ),
                        SizedBox(
                            height: 303,
                            width: MediaQuery.of(context).size.width,
                            child: homeController.appliedJobs.isNotEmpty ?
                            ListView.separated(
                                itemBuilder: (ctx, i) {
                                  int index = homeController.appliedJobs.length - 1 - i;
                                  return FutureBuilder(
                                      future: AppWriteDb.getJobById(homeController.appliedJobs[index]),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        final JobPost? jobPost = snapshot.data;
                                        if (snapshot.hasData) {
                                          if(jobPost != null){
                                            return MyDriveCard(
                                                companyPosition: jobPost.positionOffered,
                                                logo: 'assets/application_submitted.svg',
                                                companyName: jobPost.companyName,
                                                jobType: 'Internship'
                                            );
                                          }
                                          else {
                                            return const Center(child: CircularProgressIndicator(),);
                                          }
                                        } else if (snapshot.hasError) {
                                          return const Center(child: Icon(Icons.error_outline));
                                        } else {
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                      });
                                },
                                separatorBuilder: (ctx, index) {
                                  return const SizedBox(height: 4,);
                                },
                                itemCount: homeController.appliedJobs.length > 3 ? 3 : homeController.appliedJobs.length) : Center(child: Text('Not applied to any drives yet!'),)),
                      ],
                    ),
                  );
          },
        ));
  }
}

//'assets/application_submitted.svg' logo to be added.
