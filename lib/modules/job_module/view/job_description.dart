import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_applied.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

class JobDescription extends StatelessWidget {
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
        child: GradiantButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => JobApplied()));
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
                  'Junior Software Engineer',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7),
                // 3. Text widget
                Text(
                  'Valorx india',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 37),
            // 4. Row of 4 custom containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomContainer(),
                CustomContainer(),
                CustomContainer(),
                CustomContainer(),
              ],
            ),
            SizedBox(height: 56),
            // 5. Text widget
            Text(
              'Job Description',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: PlacedColors.PrimaryBlack,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            // 6. Text widget
            Text(
              "vn skdvnskdmnskvkdvnskdvnsdlkvnskdvnkvnasdjnvsjodvnsjnvdjvnjldwcvnljsvnewjvndjkcnlknvslkdnvsljfvnlsjdvnsjvnjesonvojdvnljdvnsljfdvlsjvnsdvnlsjkdvnlsjkdvnsdljvnsvjndjvnsdjvnl",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: PlacedColors.PrimaryGrey2,
                  fontWeight: FontWeight.normal
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
                  Column(
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: PlacedColors.PrimaryBlueLight2,
      child: Column(
        children: [],
      ),
    );
  }
}
