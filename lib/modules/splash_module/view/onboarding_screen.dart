import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignUp.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';


class OnBoardingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              buildImage(context),
              buildTitle(context),
              buildMessage(context),
              buildButton(context),
            ],
          )),
    );
  }

  buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'Elevate your placement journey',
        style:
        TextStyle(color: Theme.of(context).primaryColor, fontSize: MediaQuery.of(context).size.shortestSide * 0.1),
        textAlign: TextAlign.center,
      ),
    );
  }

  buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GradiantButton(
        text: 'Get Started',
        onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen())),
      ),
    );
  }

  buildMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'Streamline your placements with one-click\n apply, timely updates, and more',
        style: TextStyle(color: Colors.black87, fontSize: MediaQuery.of(context).size.shortestSide * 0.05),
        textAlign: TextAlign.center,
      ),
    );
  }

  buildImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Image.asset('assets/icon.png'),
      ),
    );
  }
}
