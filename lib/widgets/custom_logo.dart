import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE5ECF6), width: 7 ),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/onboarding.svg', // Replace with your SVG image path
        width: 32,
        height: 32,
      ),
    );
  }
}
