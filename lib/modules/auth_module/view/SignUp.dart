import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';

class MyApp extends StatefulWidget {
  final Account account;

  MyApp({required this.account});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  models.User? loggedInUser;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  Future<void> login(String email, String password) async {
    await widget.account.createEmailSession(email: email, password: password);
    final user = await widget.account.get();
    setState(() {
      loggedInUser = user;
    });
  }

  Future<void> register(String email, String password, String name) async {
    await widget.account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    await login(email, password);
  }

  Future<void> logout() async {
    await widget.account.deleteSession(sessionId: 'current');
    setState(() {
      loggedInUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(loggedInUser != null
                ? 'Logged in as ${loggedInUser!.name}'
                : 'Not logged in'),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: cpasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                login(emailController.text, passwordController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                register(emailController.text, passwordController.text,
                    cpasswordController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
              },
              child: Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                logout();
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      );
  }
}
