import 'package:get/get.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/controller/edit_profile_controller.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/edit_profile_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/splash_module/view/splash_screen.dart';
import 'package:placed_mobile_app/routes/routes.dart';

List<GetPage> pages = [
  GetPage(
    name: RouteNames.homePage,
    page: () => Home(),
  ),
  GetPage(name: RouteNames.authPage, page: () => SignInScreen()),
  GetPage(name: RouteNames.splashScreen, page: () => const SplashScreen()),
];
