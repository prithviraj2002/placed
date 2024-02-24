import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'customRow.dart';

class MyDriveCard extends StatelessWidget {
  const MyDriveCard({super.key, required this.companyPosition, required this.logo, required this.companyName, required this.jobType});

  final String companyPosition;
  final String logo;
  final String companyName;
  final String jobType;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PlacedColors.PrimaryOffWhite,
      elevation: 4,
      margin: EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 14,horizontal: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFE5ECF6), width: 1.0),
            ),
            child: SvgPicture.asset(
              logo,
              height: 32,
              width: 32,
            ),
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
                    companyPosition,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: PlacedColors.PrimaryBlack,
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomRow(companyName: companyName , icon: 'assets/building_icon.svg',),
                  SizedBox(height: 10),
                  CustomRow(companyName: jobType, icon: 'assets/time_clock_circle.svg',),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
