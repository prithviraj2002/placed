import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/constants/placed_dimensions.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/custom_card_mydrive.dart';
import 'package:placed_mobile_app/widgets/custom_card_upcomingdrive.dart';

class ViewUpcomingDrives extends StatelessWidget {
  List<JobPost> jobs;
  ViewUpcomingDrives({required this.jobs, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlacedColors.PrimaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackArrow(),
        title: Text(
          'Upcoming Drives',
          style: GoogleFonts.poppins(
            fontSize: PlacedDimens.heading_text,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        height:  MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView.separated(
            itemBuilder: (ctx, index) {
              return MyDriveCard(jobPost: jobs[index]);
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 4,);
            },
            itemCount: jobs.length),
      ),
    );
  }
}
