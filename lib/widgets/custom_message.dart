import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class CustomMessage extends StatelessWidget {
  String msgText;
  CustomMessage({required this.msgText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: ClipPath(
        clipper: UpperNipMessageClipperTwo(
          MessageType.receive
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32,horizontal: 32),
          decoration: BoxDecoration(
            color: PlacedColors.PrimaryBlueLight1,
          ),
          child: Text(
            msgText,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }
}
