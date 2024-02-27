import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/edit_profile_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/contact_us_screen.dart';
import 'package:placed_mobile_app/modules/home_module/view/reset_password.dart';

class ProfileTab extends StatefulWidget {
  HomeController controller;

  ProfileTab({required this.controller, super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.initializeUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black38)),
                    child: ClipOval(
                      child: Image.memory(
                        widget.controller.profileImagePreview.value,
                        scale: 100,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Text(
                          widget.controller.profile.value.name,
                          style: const TextStyle(fontSize: 20),
                        );
                      }),
                      Row(
                        children: [
                          InkWell(
                            child: const Text('Edit Profile'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          EditProfileScreen(
                                            profile: widget.controller
                                                .profile.value,)));
                            },
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (ctx) => const ResetPassword()));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                child: const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const ContactUs()));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text(
                            'Log out of Placed?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                              'You wont be able to view new updates regarding university placements.'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                InkWell(
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: () {
                                    showDialog(context: context, builder: (ctx){
                                      return AlertDialog(
                                        title: Text('Logging you out!'),
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                      );
                                    });
                                    final box = GetStorage();
                                    box.write('userId', '');
                                    AppWriteAuth.logout().then((value) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) => SignInScreen()),
                                                (route) => false);
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        )
    );
  }
}
