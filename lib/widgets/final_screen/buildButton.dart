import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../gradiant_button.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GradiantButton(
            widget: Text(text, style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),),
            onPressed: onPressed,
          ),
        ),
      ),
    );;
  }
}
