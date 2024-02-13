import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildImage extends StatelessWidget {
  BuildImage({super.key, required this.imageString});

  final String imageString;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 55, 15, 8),
      height: 390,
      width: 315,
      child: SvgPicture.asset(
        imageString,
        height: 300,
        width: 315,
      ),
    );
  }
}
