import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class GradiantButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  bool isEnabled;

  GradiantButton(
      {required this.onPressed, required this.text, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: isEnabled ? LinearGradient(
            begin: Alignment(1.00, -0.09),
            end: Alignment(-1, 0.09),
            colors: PlacedColors.gradiantColor) : LinearGradient(
            begin: Alignment(1.00, -0.09),
            end: Alignment(-1, 0.09),
            colors: PlacedColors.disabledGradiantColor),
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape:
          MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(12.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        )
      ),
    );
  }
}
