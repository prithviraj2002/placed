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
                        .isNotEmpty ? Image.memory(
                      widget.controller.profileImagePreview.value,
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     InkWell(
                        //       child: const Text(
                        //         'Cancel',
                        //         style: TextStyle(color: Colors.blue),
                        //       ),
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //       },
                        //     ),
                        //     InkWell(
                        //       child: const Text(
                        //         'Logout',
                        //         style: TextStyle(color: Colors.red),
                        //       ),
                        //       onTap: () {
                        //         showDialog(
                        //             context: context,
                        //             builder: (ctx) {
                        //               return AlertDialog(
                        //                 title: Text('Logging you out!'),
                        //                 content: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     CircularProgressIndicator(),
                        //                   ],
                        //                 ),
                        //               );
                        //             });
                        //         final box = GetStorage();
                        //         box.write('userId', '');
                        //         AppWriteAuth.logout().then((value) {
                        //           Future.delayed(Duration(seconds: 2), () {
                        //             Navigator.pushAndRemoveUntil(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (ctx) => SignInScreen()),
                        //                 (route) => false);
                        //           });
                        //         });
                        //       },
                        //     )
                        //   ],
                        // ),
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



// FutureBuilder(
// future: Utils.getImageUrl(widget.controller.userId),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
// if (snapshot.hasData) {
// return Image.network(
// snapshot.data,
// scale: 100,
// fit: BoxFit.cover,
// width: 70,
// height: 70,
// );
// } else if (snapshot.hasError) {
// return const Center(child: Icon(Icons.error_outline));
// } else {
// return const Center(child: CircularProgressIndicator());
// }
// })

// <<<<<<< HEAD
// const SizedBox(
// height: 20,
// ),
// InkWell(
// child: const Text(
// 'Reset Password',
// style: TextStyle(fontSize: 18),
// ),
// onTap: () {
// Navigator.push(context,
// MaterialPageRoute(
// builder: (ctx) => const ResetPassword()));
// },
// ),
// const SizedBox(
// height: 15,
// ),
// InkWell(
// child: const Text(
// 'Contact Us',
// style: TextStyle(fontSize: 18),
// ),
// onTap: () {
// Navigator.push(context,
// MaterialPageRoute(builder: (ctx) => const ContactUs()));
// },
// ),
// const SizedBox(
// height: 15,
// ),
// InkWell(
// child: const Text(
// 'Logout',
// style: TextStyle(fontSize: 18),
// ),
// onTap: () {
// showDialog(
// context: context,
// builder: (ctx) {
// return AlertDialog(
// title: const Text(
// 'Log out of Placed?',
// style: TextStyle(
// fontSize: 18, fontWeight: FontWeight.bold),
// ),
// content: const Text(
// 'You wont be able to view new updates regarding university placements.'),
// actions: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// InkWell(
// child: const Text(
// 'Cancel',
// style: TextStyle(color: Colors.blue),
// ),
// onTap: () {
// Navigator.pop(context);
// },
// ),
// InkWell(
// child: const Text(
// 'Logout',
// style: TextStyle(color: Colors.red),
// ),
// onTap: () {
// showDialog(
// context: context, builder: (ctx) {
// return AlertDialog(
// title: Text('Logging you out!'),
// content: Row(
// mainAxisAlignment: MainAxisAlignment
//     .center,
// children: [
// CircularProgressIndicator(),
// ],
// ),
// );
// });
// final box = GetStorage();
// box.write('userId', '');
// authController.logout().then((value) {
// Future.delayed(Duration(seconds: 2), () {
// Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(
// builder: (ctx) =>
// SignInScreen()),
// (route) => false);
// });
// });
// },
// )
// ],
// ),
// ],
// );
// });
// },
// ),
// =======
// >>>>>>> pranav