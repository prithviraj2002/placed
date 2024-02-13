import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildButton.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildImage.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildMessage.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildTitle.dart';


class PasswordChangedPage extends StatelessWidget {
  const PasswordChangedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          BuildImage(imageString: 'assets/password_reset.svg',),
          BuildTitle(
            text: 'Password changed!',
          ),
          SizedBox(
            height: 8,
          ),
          BuildMessage(text: 'Your password was successfully changed.\nClick below to continue logging in.',),
          BuildButton(
            text: 'Continue',
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen())),
          )
        ],
      )),
    );
  }
}
