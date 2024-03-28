import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/password_changed.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';

class ResetPassword extends StatelessWidget {
  String otp; String email;
  ResetPassword({required this.otp, required this.email, super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  AuthController authController = AuthController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 36.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomTextFieldForm(
                  hintText: 'Enter new password',
                  textInputType: TextInputType.text,
                  validator: (String? val){
                    if(val == null || val.isEmpty){
                      return 'Cannot have empty password!';
                    }
                    else if(val.length > 6){
                      return 'Password length is less than 6 characters!';
                    }
                    return '';
                  },
                  controller: passwordController,
                  obscureText: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomTextFieldForm(
                  hintText: 'Confirm password',
                  textInputType: TextInputType.text,
                  validator: (String? val) {
                    if(val == null || val.isEmpty){
                      return 'Cannot have empty value';
                    }
                    else if(val.length > 6){
                      return 'Password length is less than 6 characters!';
                    }
                    else if(val != passwordController.text){
                      return 'Passwords do not match!';
                    }
                    return '';
                  },
                  controller: passwordController,
                  obscureText: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GradiantButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    authController.updatePassword(email, otp, passwordController.text, confirmPasswordController.text).then((value){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordChangedPage()));
                    });
                  }
                },
                widget: Text('Reset Password', style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
