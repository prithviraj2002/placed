import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/controller/edit_profile_controller.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/tabs/education_tab.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/tabs/personal_tab.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/tabs/resume_tab.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/gradiant_button.dart';

class EditProfileScreen extends StatefulWidget {
  Profile profile;
  EditProfileScreen({required this.profile, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin{

  EditProfileController editProfileController = Get.find<EditProfileController>();
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    editProfileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: BackArrow(),
        bottom: TabBar(
          onTap: (int val) {},
          controller: tabController,
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
        controller: tabController,
        children: [
          EditPersonalTab(controller: editProfileController, tabController: tabController, profile: widget.profile,),
          EditEducationTab(controller: editProfileController, tabController: tabController, profile: widget.profile),
          EditResumeTab(controller: editProfileController, tabController: tabController, profile: widget.profile),
        ],
      ),
    );
  }
}
