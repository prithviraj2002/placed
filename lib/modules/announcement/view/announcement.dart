import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/models/broadcast_message_model/broadcast_message.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/modules/announcement/view/chat_screen.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';
import 'package:placed_mobile_app/utils/utils.dart';
import 'package:placed_mobile_app/widgets/custom_logo.dart';
import '../../../constants/placed_colors.dart';

class Announcement extends StatefulWidget {
  HomeController homeController;
  Announcement({required this.homeController, super.key});

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
    if(widget.homeController.appliedJobs.isNotEmpty){
      print('Applied jobs: ${homeController.appliedJobs.first}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlacedColors.PrimaryWhite,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 52,),
            Text(
              'Broadcast Channels',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: PlacedColors.PrimaryBlack),
            ),
            const SizedBox(height: 4,),
            Text(
              'Broadcast channels include messages from the T&P Dept regarding the jobs you have applied to.',
              style: GoogleFonts.poppins(
                  color: PlacedColors.PrimaryGrey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Obx(() {
              return widget.homeController.appliedJobs.isNotEmpty ?
              ListView.separated(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 0, left: 0, right: 0),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return FutureBuilder(
                        future: AppWriteDb.getJobById(
                            widget.homeController.appliedJobs[index]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          final JobPost? jobPost = snapshot.data;
                          if (snapshot.hasData) {
                            if (jobPost != null) {
                              return ListTile(
                                  contentPadding: const EdgeInsets.all(0.0),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (ctx) =>
                                            ChatScreen(jobPost: jobPost,)));
                                  },
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PlacedColors.PrimaryBlueLight1),
                                        shape: BoxShape.circle
                                    ),
                                    child: ClipOval(
                                        child: Image.network(Utils.getDeptDocUrl(widget.homeController.appliedJobs[index]), height: 32, width: 32, fit: BoxFit.cover,)),
                                  ),
                                  title: Text(jobPost.companyName,  style: TextStyle(
                                        color: PlacedColors.PrimaryBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),),
                                  subtitle: Obx(() {
                                    return announcementController.relevantMessages[widget.homeController.appliedJobs[index]]!.isNotEmpty ?
                                    Text(
                                        announcementController.relevantMessages[widget.homeController.appliedJobs[index]]!.last.message,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12, color: PlacedColors.PrimaryGrey3
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ) : Text('No new messages', style: GoogleFonts.poppins(
                                        fontSize: 12, color: PlacedColors.PrimaryGrey3
                                    ),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,);
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
                    return const SizedBox(height: 0,);
                  },
                  itemCount: widget.homeController.appliedJobs
                      .length) : const Center(
                child: Text('You have not applied to any drives yet!'),);
            })
          ],
        ),
      ),
    );
  }
}

//
// announcementController
//     .relevantMessages[homeController
//     .appliedJobs[index]]!.last.message


