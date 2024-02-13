import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_applied.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

class JobDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
        title: Text('Job Details'),
      ),
      bottomNavigationBar: GradiantButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => JobApplied()));
          },
          text: 'Apply Now',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Image widget
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/icon.png'),
                  // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 2. Text widget
            const Text(
              'Junior Software Engineer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // 3. Text widget
            Text(
              'Valorx india',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // 4. Row of 4 custom containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomContainer(),
                CustomContainer(),
                CustomContainer(),
                CustomContainer(),
              ],
            ),
            SizedBox(height: 20),
            // 5. Text widget
            Text(
              'Job Description',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // 6. Text widget
            Text(
              'Address',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // 7. Container
            Container(
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Show PDF',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.green,
    );
  }
}
