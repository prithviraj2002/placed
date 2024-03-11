import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/personal_details_module/view/personal_detail.dart';
import 'package:placed_mobile_app/modules/splash_module/view/splash_screen.dart';
import 'package:placed_mobile_app/screen_bindings/bindings/bindings.dart';
import 'package:placed_mobile_app/screen_bindings/page_bindings/page_bindings.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/auth_module/view/SignIn.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // final box = GetStorage();
  // final String userId = box.read('userId');
  runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: PageBindings(),
          getPages: pages,
          home: SplashScreen(),
    )
  );
}