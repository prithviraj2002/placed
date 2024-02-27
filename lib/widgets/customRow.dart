import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.companyName, required this.icon});

  final String companyName;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: Color(0xFF6C6C6C),
          height: 16,
          width: 16,
        ),
        SizedBox(width: 4,),
        Text(
          companyName,
          style: GoogleFonts.poppins(
            color: Color(0xFF6C6C6C),
            fontSize: 12,
          ),
        )
      ],
    );
  }
}