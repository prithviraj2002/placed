import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';

class SignInScreen extends StatefulWidget {
  final Account account;

  SignInScreen({required this.account});

  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
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

  Future<void> logout() async {
    await widget.account.deleteSession(sessionId: 'current');
    setState(() {
      loggedInUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
            size: 25,
          ),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 26.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter University Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                    fillColor: Color(0xFFE5ECF6),
                    filled: true,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Set Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.all(12.0),
                  fillColor: Color(0xFFE5ECF6),
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0XFF2D64FA), Color(0XFF43D2DF)]),
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                       login(emailController.text, passwordController.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(12.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don''t Have an Account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(account: account)));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
