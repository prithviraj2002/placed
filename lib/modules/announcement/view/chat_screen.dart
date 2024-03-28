import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/broadcast_message_model/broadcast_message.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
import 'package:placed_mobile_app/modules/job_module/view/job_description.dart';
import 'package:placed_mobile_app/utils/utils.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/custom_message.dart';
import 'package:placed_mobile_app/widgets/custom_message_withPDF.dart';
import '../../../widgets/custom_logo.dart';

class ChatScreen extends StatefulWidget {
  JobPost jobPost;

  ChatScreen({required this.jobPost, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AnnouncementController controller = Get.find<AnnouncementController>();
  ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllMessages();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToEnd();
    // });
  }

  void _scrollToEnd() {
    listScrollController.animateTo(
      listScrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 50),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => JobDescription(jobPost: widget.jobPost)));
              },
              child: Row(
                children: [
                  const BackArrow(),
                  const SizedBox(width: 6),
                  Container(
                      height: 32, width: 32,
                      decoration: BoxDecoration(
                        border: Border.all(color: PlacedColors.PrimaryBlueLight1),
                        shape: BoxShape.circle
                      ),
                      child: ClipOval(child: Image.network(Utils.getDeptDocUrl(widget.jobPost.jobId), height: 32, width: 32, scale: 10, fit: BoxFit.cover,))),
                  const SizedBox(width: 8),
                  Text(
                    widget.jobPost.companyName, // Replace with the profile name
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: PlacedColors.PrimaryBlack),
                  ),
                ],
              ),
            )),
        body: Obx(() {
          return controller.relevantMessages[widget.jobPost.jobId] != null
              ? ListView.separated(
              shrinkWrap: true,
              controller: listScrollController,
              padding: const EdgeInsets.all(20.0),
              itemBuilder: (ctx, index) {
                if (controller.relevantMessages[widget.jobPost.jobId]![index]
                    .pdfUrl
                    .isNotEmpty) {
                  return CustomMessageWithPDF(
                    text: controller.relevantMessages[widget.jobPost.jobId]![index]
                        .message,
                    pdfUrl: controller.relevantMessages[widget.jobPost.jobId]![index]
                        .pdfUrl,
                    time: controller.relevantMessages[widget.jobPost.jobId]![index].time,
                  );
                } else {
                  return CustomMessage(
                      msgText: controller.relevantMessages[widget.jobPost.jobId]![index]
                          .message,
                      time: controller.relevantMessages[widget.jobPost.jobId]![index].time
                  );
                }
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 2,
                );
              },
              itemCount:
              controller.relevantMessages[widget.jobPost.jobId]!.length)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }
}

// ListView(
// reverse: true,
// padding: const EdgeInsets.all(20.0),
// children: [
// Container(
// height: MediaQuery.of(context).size.height * 0.05,
// decoration: BoxDecoration(
// color: PlacedColors.PrimaryOffWhite,
// borderRadius: const BorderRadius.all(Radius.circular(13.0)),
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// child: Text(
// 'Broadcast channel was created',
// style: TextStyle(fontSize: 18, color: PlacedColors.PrimaryGrey2),
// textAlign: TextAlign.center,
// ),
// ),
// ),
// const CustomMessage(),
// const CustomMessageWithPDF(),
// ],
// ),
