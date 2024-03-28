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
import 'package:placed_mobile_app/modules/job_module/view/view_all_upcoming.dart';
import 'package:placed_mobile_app/widgets/custom_card_mydrive.dart';
import 'package:placed_mobile_app/widgets/custom_card_upcomingdrive.dart';

class HomeTab extends StatelessWidget {
  HomeController homeController;

  HomeTab({required this.homeController, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlacedColors.PrimaryWhite,
        body: Obx(
          () {
            return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 52,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Drives',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: PlacedColors.PrimaryBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            homeController.jobPosts.isNotEmpty && homeController.jobPosts.length > 3?
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (ctx) => ViewUpcomingDrives(jobs: homeController.jobPosts.value)));
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
                              ),
                            ) : Container(),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        homeController.jobPosts.isNotEmpty ? Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: PlacedColors.CardShadowBlack,
                                blurRadius: 16,
                                offset: Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ), child: UpcomingDriveCard()) : homeController.jobPosts.isEmpty ? Expanded(child: Center(child: Text('No job posts yet!'),)) : Expanded(child: Center(child: CircularProgressIndicator(),),),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Drives',
                              style: GoogleFonts.poppins(
                                fontSize: PlacedDimens.heading_text,
                                fontWeight: FontWeight.w600,
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
                                ),
                            ) : Container(),
                          ],
                        ),
                        SizedBox(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: homeController.appliedJobs.isNotEmpty ?
                            ListView.separated(
                              padding: const EdgeInsets.only(top: 0.0, left: 0.0),
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
                                                jobPost: jobPost,
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
                                  return const SizedBox(height: 0,);
                                },
                                itemCount: homeController.appliedJobs.length > 3 ? 3 : homeController.appliedJobs.length) : homeController.appliedJobs.isEmpty ? Center(child: Text('Not applied to any drives yet!'),) : Center(child: CircularProgressIndicator(),)),
                      ],
                    ),
                  );
          },
        ));

  }
}

//'assets/application_submitted.svg' logo to be added.
