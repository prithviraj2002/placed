import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/placed_colors.dart';

class BuildMessage extends StatelessWidget {
  const BuildMessage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: PlacedColors.greyColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );;
  }
}
