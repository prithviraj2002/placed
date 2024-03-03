import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/placed_colors.dart';

class CustomTextBottom extends StatelessWidget {
  const CustomTextBottom({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){},
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: PlacedColors.PrimaryBlack),
      ),
    );
  }
}
