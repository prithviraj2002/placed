import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class CustomMessage extends StatelessWidget {
  String msgText; String time;
  CustomMessage({required this.msgText, required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: ClipPath(
        clipper: UpperNipMessageClipperTwo(
          MessageType.receive,
          nipHeight: 12
        ),
        child: Container(
          padding: EdgeInsets.only(top: 24, bottom: 8, right: 8, left: 36),
          decoration: BoxDecoration(
            color: PlacedColors.PrimaryBlueLight2,
          ),
          child: Column(
            children: [
              Text(
                msgText,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('${DateTime.parse(time).hour.toString().padLeft(2, '0')}:${DateTime.parse(time).minute.toString().padLeft(2, '0')}', style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600, color: PlacedColors.PrimaryGrey3
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
