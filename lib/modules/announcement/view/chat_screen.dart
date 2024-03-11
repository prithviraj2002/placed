import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/broadcast_message_model/broadcast_message.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const BackArrow(),
              const SizedBox(width: 6),
              const CustomLogo(),
              const SizedBox(width: 8),
              Text(
                widget.jobPost.companyName, // Replace with the profile name
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: PlacedColors.PrimaryBlack),
              ),
            ],
          )),
        body: Obx(() {
          return controller.relevantMessages[widget.jobPost.jobId] != null ?
            ListView.separated(
            reverse: true,
            padding: const EdgeInsets.all(20.0),
            itemBuilder: (ctx, index) {
            return CustomMessage(
              msgText: controller.relevantMessages[widget.jobPost.jobId]![index]
                  .message,
            );
          },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 2,);
              },
              itemCount: controller.relevantMessages[widget.jobPost.jobId]!
                  .length) : const Center(child: CircularProgressIndicator(),);
        })
    );
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
