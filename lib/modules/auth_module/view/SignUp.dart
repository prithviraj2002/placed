import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradiant_button.dart';
import '../../home_module/view/Home.dart';

class SignupScreen extends StatefulWidget {

  final Account account;

  SignupScreen({super.key, required this.account});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  models.User? loggedInUser;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
            color: Colors.blue,
            size: 25,
          ),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
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
                validator: (val) => val!.length == 0 ? 'Empty name' : val.length < 2 ? 'Invalid name' : null,
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
                validator: (val) => val!.length == 0 ? 'Empty name' : val.length < 8 ? 'More than 8 char req' : null,
                controller: passwordController,
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradiantButton(
                    onPressed: () {
                      AuthController.signup(emailController.text, passwordController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
                      const Text(
                        'Already Have an Account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: const Text(
                          'Sign In',
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
