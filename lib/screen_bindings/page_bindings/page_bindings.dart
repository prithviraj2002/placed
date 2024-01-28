import 'package:get/get.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/auth_module/view/auth_screen.dart';
import 'package:placed_mobile_app/routes/routes.dart';

List<GetPage> pages = [
  GetPage(
    name: RouteNames.homePage,
    page: () => const Home(),
  ),
  GetPage(name: RouteNames.authPage, page: () => const AuthScreen())
];
