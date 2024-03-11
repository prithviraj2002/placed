import 'package:get/get.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/controller/edit_profile_controller.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/edit_profile_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';

import '../../modules/personal_details_module/controller/profile_controller.dart';

class PageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<AnnouncementController>(() => AnnouncementController());
  }
}