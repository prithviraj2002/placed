import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_description.dart';
import 'package:placed_mobile_app/modules/profile_module/controller/profile_controller.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/education_tab.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/personal_detail_tab.dart';
import 'package:placed_mobile_app/modules/profile_module/view/tabs/resume_tab.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

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
  ProfileController profileController = Get.find<ProfileController>();

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
          onTap: (int val) {},
          controller: _tabController,
          indicatorColor: PlacedColors.PrimaryBlueMain,
          labelColor: PlacedColors.PrimaryBlack,
          tabs: [
            Tab(text: 'Personal'),
            Tab(text: 'Education'),
            Tab(text: 'Resume'),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          PersonalTab(controller: profileController, tabController: _tabController,),
          EducationTab(controller: profileController, tabController: _tabController),
          ResumeTab(controller: profileController, tabController: _tabController),
        ],
      ),
    );
  }
}
