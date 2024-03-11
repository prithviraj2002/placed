import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/splash_module/view/splash_screen.dart';
import 'package:placed_mobile_app/screen_bindings/bindings/bindings.dart';
import 'package:placed_mobile_app/screen_bindings/page_bindings/page_bindings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  final String? userId = box.read('userId');
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notification',
          channelDescription: 'Notification channel for basic notifications'
      )
    ],
    debug: true
  );
  runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: PageBindings(),
          getPages: pages,
          home: userId == null ? SplashScreen() : userId.isEmpty ? SplashScreen() : Home(),
    )
  );
}
