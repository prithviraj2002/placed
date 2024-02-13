import 'package:flutter/material.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/reset_password.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';

class EnterOTP extends StatelessWidget {
  EnterOTP({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                textInputType: TextInputType.emailAddress,
                validator: (val) => val!.length == 0
                    ? 'Empty name'
                    : val.length < 2
                    ? 'Invalid name'
                    : null,
                controller: emailController,
                obscureText: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GradiantButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword()));
              },
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
