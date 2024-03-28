import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:placed_mobile_app/utils/utils.dart';
import '../constants/placed_colors.dart';
import '../modules/home_module/controller/home_controller.dart';
import '../modules/job_module/view/job_description.dart';

class UpcomingDriveCard extends StatefulWidget {
  const UpcomingDriveCard({super.key});

  @override
  State<UpcomingDriveCard> createState() => _UpcomingDriveCardState();
}

class _UpcomingDriveCardState extends State<UpcomingDriveCard> {
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (ctx, i) {
          int index = homeController.jobPosts.length - 1 - i;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: PlacedColors.PrimaryBlueLight1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: PlacedColors.PrimaryWhite,
            ),
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 213,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          border: Border.all(color: PlacedColors.PrimaryBlueLight1)
                      ),
                      child: ClipOval(
                          child: Image.network(Utils.getDeptDocUrl(homeController.jobPosts[index].jobId), scale: 10, height: 32, width: 32, fit: BoxFit.cover,)),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        homeController.jobPosts[index].companyName,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: PlacedColors.PrimaryBlack),
                      ),
                    ),
                    Spacer(),
                    //ToDo: Check for eligibility and display here.
                    Container(
                      margin: EdgeInsets.all(6),
                      height: 20,
                      width: 55,
                      decoration:
                          BoxDecoration(color: PlacedColors.SecondaryGreen3, borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          'Eligible',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                              fontSize: 12, color: PlacedColors.SecondaryGreen2),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomRow(
                      title: homeController.jobPosts[index].positionOffered,
                      icon: 'assets/suitcase.svg',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    CustomRow(
                      title: homeController.jobPosts[index].jobType,
                      icon: 'assets/window_clock.svg',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    CustomRow(
                      title: "Apply by ${homeController.jobPosts[index].endDate.substring(0, 10)}",
                      icon: 'assets/hourglass.svg',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient:
                        LinearGradient(colors: PlacedColors.gradiantColor),
                  ),
                  width: 255,
                  height: 36,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobDescription(jobPost: homeController.jobPosts[index])));
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'View Details',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 8,
          );
        },
        itemCount: homeController.jobPosts.length,
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 16,
          width: 16,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: PlacedColors.PrimaryGrey2,
            fontSize: 12,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}

// SvgPicture.asset(
// 'assets/application_submitted.svg',
// height: 32,
// width: 32,
// ),
