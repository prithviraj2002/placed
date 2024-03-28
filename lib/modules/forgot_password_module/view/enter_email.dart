import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/enter_otp.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';

class EnterEmail extends StatelessWidget {
  EnterEmail({super.key});

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();

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
              Text(
                'Forgot Password',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4,),
              Text('Enter your university email and we will share a reset link to it.', style: GoogleFonts.poppins(
                fontSize: 12, color: PlacedColors.PrimaryGrey3
              ),),
              const SizedBox(height: 32.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomTextFieldForm(
                  hintText: 'Enter University Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (String? val){
                    if(val == null){
                      return 'Email is empty.';
                    }
                    return null;
                  },
                  controller: emailController,
                  obscureText: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GradiantButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    authController.createRecovery(emailController.text).then((value) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EnterOTP(email: emailController.text,)));
                      showDialog(context: context, builder: (ctx){
                        return CupertinoAlertDialog(
                          title: Text('Link sent!', style: GoogleFonts.poppins(fontSize: 16),),
                          content: Text('We have sent a password reset link to your registered email.' ,style: GoogleFonts.poppins(fontSize: 12, ),),
                          actions: [
                            TextButton(onPressed: () {
                              showDialog(context: context, builder: (ctx){
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => SignInScreen()), (route) => false);
                                });
                                return CupertinoAlertDialog(
                                  title: Text('Going back to Sign in screen'),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                );
                              });
                            }, child: Text('Okay', style: GoogleFonts.poppins(fontSize: 16, color: PlacedColors.PrimaryBlueMain),))
                          ],
                        );
                      });
                    });
                  }
                },
                widget: Text('Send Link', style: GoogleFonts.lato(
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
