import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:placed_mobile_app/modules/splash_module/view/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
            child: Animate(
                effects: const [
                  FadeEffect(delay: Duration(seconds: 2), duration: Duration(seconds: 3))
                ],
                onComplete: (controller) {
                  if(controller.isCompleted){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => OnBoardingPage()), (route) => false);
                  }
                },
                child: const Text('Placed', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)
            )
        )
    );
  }
}
