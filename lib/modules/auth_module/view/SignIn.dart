import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignUp.dart';
import 'package:placed_mobile_app/modules/forgot_password_module/view/enter_email.dart';
import 'package:placed_mobile_app/modules/profile_module/view/personal_detail.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/custom_text_field.dart';

import '../../../widgets/gradiant_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  models.User? loggedInUser;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 26.0),
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
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomTextFieldForm(
                hintText: 'Set Password',
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (val) => val!.length == 0
                    ? 'Empty name'
                    : val.length < 8
                        ? 'More than 8 char req'
                        : null,
                controller: passwordController,
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
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  GradiantButton(
                    onPressed: () {
                      AuthController.login(
                          emailController.text, passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalDetail()));
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
                      const Text(
                        'Don' 't Have an Account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
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
    );
  }
}
