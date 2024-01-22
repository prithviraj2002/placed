import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:placed_mobile_app/Screens/Auth/SignUp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client();
  client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("659f955654db1b66e4b6");
  ;
  Account account = Account(client);

  runApp(MaterialApp(home: MyApp(account: account)));
}