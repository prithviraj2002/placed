import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/announcement/view/announcement.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/tabs/announcements_screen.dart';
import 'package:placed_mobile_app/modules/home_module/view/tabs/home_screen.dart';
import 'package:placed_mobile_app/modules/home_module/view/tabs/profile_screen.dart';
import 'package:placed_mobile_app/modules/job_module/view/viewAll.dart';

import 'package:placed_mobile_app/widgets/custom_card_mydrive.dart';

import '../../../constants/placed_dimensions.dart';
import '../../../widgets/custom_card_upcomingdrive.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,size: PlacedDimens.home_icon_size,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/announcement.svg',
                    color: _selectedIndex == 1 ? PlacedColors.PrimaryBlueMain : PlacedColors.PrimaryBlack,
                    height: PlacedDimens.home_icon_size,
                    width: PlacedDimens.home_icon_size,
                  ),

                ),
                label: 'Announcements',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/time_clock_circle.svg',
                    color: _selectedIndex == 2 ? PlacedColors.PrimaryBlueMain : PlacedColors.PrimaryBlack,
                    height: PlacedDimens.home_icon_size,
                    width: PlacedDimens.home_icon_size,
                  ),
                ),
                label: 'Profile',
              ),
        ]),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeTab(homeController: homeController),
            Announcement(),
            // AnnouncementsTab(controller: homeController),
            ProfileTab(controller: homeController),
          ],
        )
    );
  }
}
