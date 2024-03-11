import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import 'package:placed_mobile_app/widgets/custom_message.dart';
import 'package:placed_mobile_app/widgets/custom_message_withPDF.dart';
import '../../../widgets/custom_logo.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackArrow(),
            SizedBox(width: 6),
            CustomLogo(),
            SizedBox(width: 8),
            Text(
              'ValorX', // Replace with the profile name
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: PlacedColors.PrimaryBlack),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          reverse: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                color: PlacedColors.PrimaryOffWhite,
                borderRadius: const BorderRadius.all(Radius.circular(13.0)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'Broadcast channel was created',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: PlacedColors.PrimaryGrey4,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CustomMessage(),
            CustomMessageWithPDF(),
          ],
        ),
      ),
    );
  }
}
