import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_description.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/education_tab.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/personal_detail_tab.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/resume_tab.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

void main() {
  runApp(const PersonalDetail());
}

class PersonalDetail extends StatelessWidget {
  const PersonalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompleteProfileScreen(),
    );
  }
}

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Profile'),
        leading: BackArrow(),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Personal'),
            Tab(text: 'Education'),
            Tab(text: 'Resume'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GradiantButton(
          onPressed: () {
            if(_tabController.index == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => JobDescription()));
            }else{
              _tabController.animateTo((_tabController.index + 1));
            }
          },// Switch tabs
          text: 'Continue',
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PersonalTab(),
          EducationTab(),
          ResumeTab(),
        ],
      ),
    );
  }
}