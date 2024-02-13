import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/enter_otp.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';

class EnterEmail extends StatelessWidget {
  EnterEmail({super.key});

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
                        builder: (context) => EnterOTP()));
              },
              text: 'Get OTP',
            ),
          ],
        ),
      ),
    );
  }
}