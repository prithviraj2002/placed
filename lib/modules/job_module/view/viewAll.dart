import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/placed_dimensions.dart';
import '../../../widgets/custom_card_mydrive.dart';
import '../../home_module/controller/home_controller.dart';

class ViewAll extends StatelessWidget {
  ViewAll({super.key});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Drives',
          style: GoogleFonts.poppins(
            fontSize: PlacedDimens.heading_text,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        height:  MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) {
                    return MyDriveCard(
                      companyPosition: homeController.jobPosts[index]
                          .positionsOffered[i].toString(),
                      logo: 'assets/application_submitted.svg',
                      companyName: homeController.jobPosts[index]
                          .companyName,
                      jobType: homeController.jobPosts[index]
                          .endDate.toString(),
                      );
                  }, separatorBuilder: (ctx, index) {
                return const SizedBox(height: 2,);
              }, itemCount: homeController.jobPosts[index]
                  .positionsOffered.length);
              // return CustomCard(companyPosition: homeController.jobPosts[index].positionsOffered[i].toString(), logo: 'assets/application_submitted.svg',);
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(width: 10,);
            },
            itemCount: homeController.jobPosts.length),
      ),
    );
  }
}

