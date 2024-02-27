import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/modules/announcement/view/announcement.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/modules/home_module/view/Home.dart';
import 'package:placed_mobile_app/modules/profile/view/profile_tab.dart';
import '../../../constants/placed_dimensions.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  HomeController homeController = Get.find<HomeController>();
  int _selectedIndex = 0;
  List<Color> selectedColor = [PlacedColors.PrimaryBlueDark];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<Widget> widgetList = [
    Home(),
    Announcement(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            unselectedItemColor:  PlacedColors.PrimaryBlack,
            selectedItemColor: PlacedColors.PrimaryBlueMain,
            onTap: _onItemTapped,
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
          children: widgetList,
          index: _selectedIndex,
        ));
  }
}
