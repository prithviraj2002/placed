import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/custom_eye_field.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';
import '../../personal_details_module/view/personal_detail.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                'Sign Up',
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
                    } else if (!val.contains('@') || !val.contains('indus')) {
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
                  hintText: 'Set Password',
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Empty Password!";
                    } else if (val.length < 8) {
                      return 'Password should be at least of 8 characters!';
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomEYEFieldForm(
                  hintText: 'Confirm Password',
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Empty Password!";
                    } else if (val.length < 8) {
                      return 'Password should be at least of 8 characters!';
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 4, 0, 0),
                child: Text(
                  'Your password must range between 8 to 12 characters including letters and numbers.',
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: PlacedColors.PrimaryGrey3,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 32.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GradiantButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthController.signup(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value.$createdAt.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PersonalDetail()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('An error occurred!')));
                            }
                          });
                        }
                      },
                      text: 'Sign Up',
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
                          'Already Have an Account?',
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
                                    builder: (context) => SignInScreen()));
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                              color: PlacedColors.PrimaryBlueMain,
                              fontSize: 16.0,
                                fontWeight: FontWeight.w500
                            ),
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
