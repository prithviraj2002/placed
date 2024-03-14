import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/splash_module/view/splash_screen.dart';
import 'package:placed_mobile_app/notification/push_notification.dart';
import 'package:placed_mobile_app/screen_bindings/bindings/bindings.dart';
import 'package:placed_mobile_app/screen_bindings/page_bindings/page_bindings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future _firebaseBackgroundMessage(RemoteMessage message)async{
  if(message.notification != null){
    print("Some notification Received");
  }
  else{
    print("No message");
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotification.init();
  FirebaseMessaging.onBackgroundMessage((message) => _firebaseBackgroundMessage(message));
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if(message.notification != null){
      print('Background Notification Tapped');
      navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => const Home()));
    }
  });
  PushNotification.localNotiInit();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('ForeGround Notification Tapped');
    if(message.notification != null){
      PushNotification.showSimpleNotification(title: message.notification!.title!, body: message.notification!.body!);
    }
  });
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