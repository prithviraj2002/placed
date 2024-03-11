import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
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
  AuthController authController = AuthController();

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
      appBar: AppBar(),
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
                style: TextStyle(
                  color: PlacedColors.PrimaryBlack,
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
                  validator: (val) {
                    if(val == null || val.isEmpty){
                      return 'Empty Email';
                    }
                    else if(!val.contains('@') || !val.contains('indus')){
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
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomTextFieldForm(
                  hintText: 'Set Password',
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (val) {
                    if(val == null || val.isEmpty){
                      return "Empty Password!";
                    }
                    else if(val.length < 8){
                      return 'Password should be at least of 8 characters!';
                    }
                    return null;
                  },
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
                        if(formKey.currentState!.validate()){
                          showDialog(context: context, builder: (ctx){
                            return AlertDialog(
                              title: Text('Signing up'),
                              content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator()],),
                            );
                          });
                          authController.signup(emailController.text, passwordController.text).then((value) {
                            if(value.$createdAt.isNotEmpty){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDetail()));
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred!')));
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
                        const Text(
                          'Already Have an Account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => SignInScreen()), (route) => false);
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
      ),
    );
  }
}
