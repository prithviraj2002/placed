import 'package:flutter/material.dart';
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
            text: text,
            onPressed: onPressed,
          ),
        ),
      ),
    );;
  }
}
