import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:placed_mobile_app/modules/announcement/view/chat_screen.dart';
import 'package:placed_mobile_app/widgets/custom_logo.dart';

import '../../../constants/placed_colors.dart';
import '../../../constants/placed_dimensions.dart';

class Announcement extends StatelessWidget {
  const Announcement({super.key});

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
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                    },
                    child: ListTile(
                      leading: CustomLogo(),
                      title: Text(
                        'Valorx India',
                        style: TextStyle(
                          color: PlacedColors.PrimaryBlack,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        style: TextStyle(
                          color: PlacedColors.PrimaryGrey3,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    width: 16,
                  );
                },
                itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
