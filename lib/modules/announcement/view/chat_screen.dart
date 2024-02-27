import 'package:flutter/material.dart';
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          reverse: true,
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                color: PlacedColors.PrimaryOffWhite,
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'Broadcast channel was created',
                  style: TextStyle(fontSize: 18, color: PlacedColors.PrimaryGrey2),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const CustomMessage(),
            const CustomMessageWithPDF(),
          ],
        ),
      ),
    );
  }
}
