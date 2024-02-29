import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
import 'package:placed_mobile_app/modules/announcement/view/chat_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/widgets/custom_logo.dart';

import '../../../constants/placed_colors.dart';
import '../../../constants/placed_dimensions.dart';

class Announcement extends StatefulWidget {
  Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  HomeController homeController = Get.find<HomeController>();

  AnnouncementController announcementController =
  Get.find<AnnouncementController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    announcementController.getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Broadcast Channels',
          style: TextStyle(
            fontSize: PlacedDimens.heading_text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'Broadcast channels include one-sided messages from the T&P Dept. regarding the jobs you have applied to',
              style: TextStyle(
                color: PlacedColors.PrimaryGrey3,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              return homeController.appliedJobs.isNotEmpty ?
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return FutureBuilder(
                        future: AppWriteDb.getJobById(
                            homeController.appliedJobs[index]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          final JobPost? jobPost = snapshot.data;
                          if (snapshot.hasData) {
                            if (jobPost != null) {
                              return ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (ctx) =>
                                            ChatScreen(jobPost: jobPost,)));
                                  },
                                  leading: const CustomLogo(),
                                  title: Text(jobPost.companyName),
                                  subtitle: Obx(() {
                                    if(announcementController.relevantMessages.containsKey(homeController.appliedJobs[index])){
                                      return announcementController.relevantMessages[homeController.appliedJobs[index]] != null ?
                                      Text(announcementController
                                          .relevantMessages[homeController
                                          .appliedJobs[index]]!.last.message,
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,) : LinearProgressIndicator();
                                    }
                                    else{
                                      return const Text('No new messages');
                                    }
                                  })
                              );
                            }
                            else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Icon(Icons.error_outline));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(height: 4,);
                  },
                  itemCount: homeController.appliedJobs
                      .length) : const Center(
                child: Text('You have not applied to any drives yet!'),);
            })
          ],
        ),
      ),
    );
  }
}




