import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class CustomMessageWithPDF extends StatelessWidget {
  const CustomMessageWithPDF({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: ClipPath(
        clipper: UpperNipMessageClipperTwo(MessageType.receive),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          decoration: BoxDecoration(
            color: PlacedColors.PrimaryBlueLight1,
          ),
          child: Column(
            children: [
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida, mauris vitae lacinia pretium, sapien mi interdum velit, ac finibus enim tellus nec sapien. Mauris et commodo justo. Vestibulum non urna erat. Donec at gravida eros, quis auctor nulla.',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 34,
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: PlacedColors.PrimaryBlueLight1,
                    border:
                        Border.all(color: PlacedColors.PrimaryWhite, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/pdf_icon.svg',
                      height: 48,
                      width: 36,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Campus Drive',
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: PlacedColors.PrimaryBlack),
                          ),
                          Text(
                            '4.1 MB',
                            style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: PlacedColors.PrimaryGrey2,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
