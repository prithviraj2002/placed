import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/reset_password.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';

class EnterOTP extends StatelessWidget {
  String email;
  EnterOTP({required this.email, super.key});

  final TextEditingController otpController = TextEditingController();
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
                'Check your email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'We’ve sent a verification code at the mentioned\nemail. Enter the code below:',
                style: TextStyle(
                  color: PlacedColors.greyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 36.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomTextFieldForm(
                  hintText: 'Enter OTP',
                  textInputType: TextInputType.text,
                  validator: (String? val){
                    if(val == null || val.isEmpty){
                      return 'Cannot have an empty code!';
                    }
                    return '';
                  },
                  controller: otpController,
                  obscureText: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GradiantButton(
                onPressed: () {
                  if(formKey.currentState!.validate() && otpController.text.isNotEmpty && email.isNotEmpty){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword(otp: otpController.text, email: email,)));
                  }
                },
                text: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
