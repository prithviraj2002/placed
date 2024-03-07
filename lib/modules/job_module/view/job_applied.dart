import 'package:flutter/material.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildButton.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildImage.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildMessage.dart';
import 'package:placed_mobile_app/widgets/final_screen/buildTitle.dart';

class JobApplied extends StatelessWidget {
  JobPost jobPost;
  JobApplied({required this.jobPost, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              BuildImage(imageString: 'assets/application_submitted.svg',),
              BuildTitle(text:  'Application submitted to ${jobPost.companyName}',),
              const SizedBox(height: 8,),
              BuildMessage(text: 'You will now receive all the notifications\nregarding this drive.',),
              BuildButton(text:  'Get Started', onPressed: () =>
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => Home()), (route) => false)
              ),
            ],
          )),
    );
  }
}
