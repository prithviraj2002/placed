import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';

class CustomEYEFieldForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  State<CustomEYEFieldForm> createState() => _CustomEYEFieldFormState();

  CustomEYEFieldForm({
    required this.hintText,
    required this.textInputType,
    required this.validator,
    required this.controller,
    required this.obscureText,
  });
}

class _CustomEYEFieldFormState extends State<CustomEYEFieldForm> {
  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: passwordVisible,
      style: GoogleFonts.poppins(
        color: PlacedColors.PrimaryBlack,
        fontSize: 16,
        letterSpacing: 1.2,
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
          icon: Icon(
              passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off),),
        fillColor: PlacedColors.PrimaryBlueLight1,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.all(12.0),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          color: PlacedColors.PrimaryGrey3,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(fontSize: MediaQuery.of(context).size.shortestSide * 0.03, letterSpacing: 0.8),
      ),
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}
