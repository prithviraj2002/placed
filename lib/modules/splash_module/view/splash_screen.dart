import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:placed_mobile_app/modules/splash_module/view/onboarding_screen.dart';

import '../../../constants/placed_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: PlacedColors.gradiantColor),
          ),
          child: Center(
              child: Animate(
                  effects: const [
                    FadeEffect(delay: Duration(seconds: 1), duration: Duration(seconds: 2))
                  ],
                  onComplete: (controller) {
                    if(controller.isCompleted){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => OnBoardingPage()), (route) => false);
                    }
                  },
                  child: const Text('Placed', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)
              )
          ),
        )
    );
  }
}
