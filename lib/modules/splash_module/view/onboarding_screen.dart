import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildButton.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildImage.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildMessage.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildTitle.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          BuildImage(
            imageString: 'assets/onboarding.svg',
          ),
          BuildTitle(
            text: 'Elevate your placement journey',
          ),
          SizedBox(
            height: 8,
          ),
          BuildMessage(
              text:
                  'Streamline your placements with one-click\n apply, timely updates, and more'),
          BuildButton(
            text: 'Get Started',
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen())),
          )
        ],
      )),
    );
  }
}
