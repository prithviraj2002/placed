import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/modules/announcement/view/chat_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/utils/utils.dart';
import 'package:placed_mobile_app/widgets/custom_logo.dart';
import '../../../constants/placed_colors.dart';

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
        title: Text(
          'Broadcast Channels',
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: PlacedColors.PrimaryBlack),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'Broadcast channels include one-sided messages from the T&P Dept. regarding the jobs you have applied to',
              style: GoogleFonts.poppins(
                  color: PlacedColors.PrimaryGrey3,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
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
                                  leading: Image.network(Utils.getDeptDocUrl(homeController.appliedJobs[index]), height: 32, width: 32, scale: 10,),
                                  title: Text(jobPost.companyName,  style: TextStyle(
                                        color: PlacedColors.PrimaryBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),),
                                  subtitle: Obx(() {
                                    if(announcementController.relevantMessages.containsKey(homeController.appliedJobs[index])){
                                      return announcementController.relevantMessages[homeController.appliedJobs[index]] != null ?
                                      Text(announcementController
                                          .relevantMessages[homeController
                                          .appliedJobs[index]]!.last.message,
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.poppins(
                                        color: PlacedColors.PrimaryGrey3,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                        ) : LinearProgressIndicator();
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
                    return const SizedBox(height: 16,);
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




