import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import '../../constants/placed_dimensions.dart';

class BuildTitle extends StatelessWidget {
  const BuildTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: PlacedColors.PrimaryBlack,
        fontWeight: FontWeight.w600,
        fontSize: PlacedDimens.font_size_16,
      ),
      textAlign: TextAlign.center,
    );
  }
}
