import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.blue,
        size: 25,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
