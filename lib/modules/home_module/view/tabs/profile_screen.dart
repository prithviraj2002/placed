import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/modules/auth_module/controller/auth_controller.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignUp.dart';
import 'package:placed_mobile_app/modules/edit_profile_module/view/edit_profile_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/contact_us_screen.dart';
import 'package:placed_mobile_app/modules/home_module/view/reset_password.dart';
import 'package:placed_mobile_app/utils/utils.dart';

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

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlacedColors.PrimaryWhite,
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
                child: Obx(() {
                  return ClipOval(
                    child: widget.controller.profileImagePreview.value
                        .isNotEmpty ? Image.network(
                      Utils.getImageUrl(widget.controller.userId),
                      scale: 100,
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                    ) : CircularProgressIndicator(),
                  );
                }),
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
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: PlacedColors.PrimaryBlack),
                );
              }),
              Row(
                children: [
                  InkWell(
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: PlacedColors.PrimaryGrey2),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => EditProfileScreen(
                                    profile:
                                        widget.controller.profile.value,
                                  )));
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
          ],),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            child: Text(
              'Reset Password',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: PlacedColors.PrimaryBlack),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const ResetPassword()));
            },
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            child: Text(
              'Contact Us',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: PlacedColors.PrimaryBlack),
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
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: PlacedColors.PrimaryBlack),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return CupertinoAlertDialog(
                      title: Text(
                        'Log out of Placed?',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: PlacedColors.PrimaryBlack),
                      ),
                      content: Text(
                        'You wont be able to view new updates regarding university placements.',
                        style: GoogleFonts.poppins(
                            color: PlacedColors.PrimaryBlack,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.blue,fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        CupertinoDialogAction(
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return CupertinoAlertDialog(
                                      title: Text('Logging you out!'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
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
                            child: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.red,fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
          const SizedBox(height: 15,),
          InkWell(
            child: Text(
              'Delete account',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: PlacedColors.SecondaryRed),
            ),
            onTap: () {
              showDialog(context: context, builder: (ctx){
                return AlertDialog(
                  surfaceTintColor: PlacedColors.PrimaryWhite,
                  title: Text('Delete Account?'),
                  content: Text('This will delete all your profile related data.'),
                  actions: [
                    TextButton(onPressed: () {Navigator.pop(context);}, child: Text('No')),
                    TextButton(onPressed: () {
                      widget.controller.delProfile().then((value){
                        authController.logout();
                        showDialog(context: context, builder: (ctx){
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => SignUpScreen()), (route) => false);
                          });
                          return AlertDialog(
                            title: Text('Deleting profile'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(child: CircularProgressIndicator(),)
                              ],
                            ),
                          );
                        });
                      });
                    }, child: Text('Yes'))
                  ],
                );
              });
            },
          ),
        ],
      ),
    ),);
  }
}
