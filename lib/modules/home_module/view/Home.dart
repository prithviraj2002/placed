import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/job_module/view/viewAll.dart';
import 'package:placed_mobile_app/widgets/custom_card_mydrive.dart';
import '../../../constants/placed_dimensions.dart';
import '../../../widgets/custom_card_upcomingdrive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Upcoming Drives',
            style: TextStyle(
              fontSize: PlacedDimens.heading_text,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Obx(() {
          return homeController.jobPosts.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                child: Container(
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
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewAll()));
                                },
                                child: Text(
                                  'View all',
                                  style: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                    decorationColor: PlacedColors.PrimaryBlueMain,
                                    color: PlacedColors.PrimaryBlueMain,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 303,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return MyDriveCard(
                                      companyPosition:  homeController.jobPosts[index].positionsOffered[i].toString(),
                                      logo: 'assets/application_submitted.svg',
                                      companyName: homeController.jobPosts[index].companyName,
                                      jobType: homeController.jobPosts[index].endDate.toString(),
                                    );
                                  }, separatorBuilder: (ctx, i) {
                                    return const SizedBox(height: 2,);
                                },
                                  itemCount: homeController.jobPosts.length,
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              itemCount: homeController.jobPosts.length),
                        ),
                      ],
                    ),
                  ),
              );
        }));
  }
}
