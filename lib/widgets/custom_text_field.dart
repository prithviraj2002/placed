import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 16,
            letterSpacing: 1.2,
      ),
      decoration: InputDecoration(
        fillColor: Color(0xFFE5ECF6),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.all(12.0),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(fontSize: MediaQuery.of(context).size.shortestSide * 0.03, letterSpacing: 0.8),
      ),
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
    );
  }

  CustomTextFieldForm({
    required this.hintText,
    required this.textInputType,
    required this.validator,
    required this.controller,
    required this.obscureText,
  });
}
