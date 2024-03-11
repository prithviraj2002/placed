import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class CustomListTile extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  CustomListTile({
    required this.leadingIcon,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Leading icon
          Stack(
            children: [
              Container(
                width: 54.0,
                height: 54.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  leadingIcon,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 30.0,
                left: 30.0,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/edit_image_photo.png'),
                    onPressed: () async {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title text
                Text(
                  title,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: PlacedColors.PrimaryBlack),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: PlacedColors.PrimaryGrey2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
