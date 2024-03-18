import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/enter_otp.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';

class EnterEmail extends StatelessWidget {
  EnterEmail({super.key});

  final TextEditingController emailController = TextEditingController();
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
                'Forgot Password',
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
                  hintText: 'Enter University Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (String? val){
                    // if(val == null){
                    //   return 'Empty email is invalid!';
                    // }
                    // else if(!val.contains('@') || !val.contains('indus')){
                    //   return 'Not a valid indus email id!';
                    // }
                    // return '';
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
                    AuthController.createRecovery(emailController.text).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnterOTP(email: emailController.text,)));
                    });
                  }
                },
                text: 'Get OTP',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
