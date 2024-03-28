import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/constants/placed_colors.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/widgets/back_arrow.dart';
import '../../../constants/placed_dimensions.dart';
import '../../../widgets/custom_card_mydrive.dart';
import '../../home_module/controller/home_controller.dart';

class ViewAll extends StatelessWidget {
  List<dynamic> appliedJobs;
  ViewAll({required this.appliedJobs, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlacedColors.PrimaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackArrow(),
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
            itemBuilder: (ctx, index) {
              return FutureBuilder(
                  future: AppWriteDb.getJobById(appliedJobs[index]),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    final JobPost? jobPost = snapshot.data;
                    if (snapshot.hasData) {
                      if(jobPost != null){
                        return MyDriveCard(
                            jobPost: jobPost,
                        );
                      }
                      else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    } else if (snapshot.hasError) {
                      return const Center(child: Icon(Icons.error_outline));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 4,);
            },
            itemCount: appliedJobs.length),
      ),
    );
  }
}

