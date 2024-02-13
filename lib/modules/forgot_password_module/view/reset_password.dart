import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/password_changed.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';
import '../../profile_module/view/personal_detail.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

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
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomTextFieldForm(
                hintText: 'Confirm password',
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
                        builder: (context) => PasswordChangedPage()));
              },
              text: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
