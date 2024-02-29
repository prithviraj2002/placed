import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/modules/announcement/controller/announcements_controller.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';

class AnnouncementsTab extends StatelessWidget {
  HomeController controller;

  AnnouncementsTab({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 100,),
          const Text('Broadcast Channels'),
          const SizedBox(
            height: 10,
          ),
          const Text('Descriptive text here'),
          Obx(() {
            return controller.appliedJobs.isNotEmpty?
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return FutureBuilder(
                    future: AppWriteDb.getJobById(controller.appliedJobs[index]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final JobPost jobPost = snapshot.data;
                        return ListTile(
                          title: Text(jobPost.companyName),
                        );
                      } else if (snapshot.hasError) {
                        return const Icon(Icons.error_outline);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 10,);
              },
              itemCount: controller.appliedJobs.length,
            ) : const Center(child: Text('Start applying to jobs.'),);
          })
        ],
      ),
    );
  }
}
