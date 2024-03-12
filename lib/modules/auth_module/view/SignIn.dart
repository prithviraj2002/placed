import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignUp.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/enter_email.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/personal_details_module/view/personal_detail.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/custom_eye_field.dart';
import 'package:placed_mobile_app/widgets/custom_text_field.dart';

import '../../../widgets/gradiant_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackArrow(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Sign In',
                style: GoogleFonts.poppins(
                  color: PlacedColors.PrimaryBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 26.0),
              Container(
                decoration: BoxDecoration(
                  color: PlacedColors.PrimaryBlueLight2,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomTextFieldForm(
                  hintText: 'Enter University Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Empty Email';
                    } else if (!val.contains('@')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  controller: emailController,
                  obscureText: false,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: PlacedColors.PrimaryBlueLight2,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomEYEFieldForm(
                  hintText: 'Enter Password',
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: passwordController,
                  validator: (String? val) {
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnterEmail()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryBlueMain),
                      ),
                    ),
                    GradiantButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthController.login(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value.$createdAt.isNotEmpty) {
                              final box = GetStorage();
                              final String userId = box.read('userId');
                              if (userId.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              } else if (userId.isEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalDetail()));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('An error occurred!')));
                            }
                          });
                        }
                      },
                      text: 'Sign In',
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'Don' 't Have an Account?',
                          style: GoogleFonts.poppins(
                              color: PlacedColors.PrimaryBlack,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
