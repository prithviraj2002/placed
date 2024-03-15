import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_description.dart';
import 'package:placed_mobile_app/utils/utils.dart';
import 'customRow.dart';

class MyDriveCard extends StatelessWidget {
  JobPost jobPost;
  MyDriveCard({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => JobDescription(jobPost: jobPost)));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: PlacedColors.PrimaryBlueMain.withOpacity(0.1),
              blurRadius: 16,
              offset: Offset(3, 4), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: PlacedColors.PrimaryOffWhite,
        ),
        margin: EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(vertical: 14,horizontal: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: PlacedColors.PrimaryWhite, width: 1.0),
              ),
              child: Image.network(Utils.getDeptDocUrl(jobPost.jobId), height: 32, width: 32, scale: 10,)
            ),
            // Second part with text
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title text
                    Text(
                      jobPost.positionOffered,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: PlacedColors.PrimaryBlack,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomRow(companyName: jobPost.companyName , icon: 'assets/building_icon.svg',),
                    SizedBox(height: 10),
                    CustomRow(companyName: jobPost.jobType, icon: 'assets/time_clock_circle.svg',),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SvgPicture.asset(
// logo,
// height: 32,
// width: 32,
// ),
