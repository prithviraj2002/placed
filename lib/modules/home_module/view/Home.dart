import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:placed_mobile_app/appwrite/appwrite_auth/appwrite_auth.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/models/job_model.dart';
import 'package:placed_mobile_app/models/profile_model/profile_model.dart';
import 'package:placed_mobile_app/modules/auth_module/view/SignIn.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming Drives'),
          actions: [
            TextButton(onPressed: () {
              final box = GetStorage();
              box.write('userId', '');
              // AppWriteAuth.logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => SignInScreen()), (route) => false);
            }, child: Text('Logout'))
          ],
        ),
        body: Obx(() {
          return homeController.jobPosts.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 6),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 220,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      homeController
                                          .jobPosts[index].companyName,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, i) {
                                          return Text(
                                            homeController.jobPosts[index]
                                                .positionsOffered[i]
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          );
                                        },
                                        separatorBuilder: (ctx, index) {
                                          return const SizedBox(
                                            height: 2,
                                          );
                                        },
                                        itemCount: homeController
                                            .jobPosts[index]
                                            .positionsOffered
                                            .length),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Package range:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          homeController
                                              .jobPosts[index].package[0]
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          homeController
                                              .jobPosts[index].package[1]
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'Apply by:',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      homeController.jobPosts[index].endDate
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    OutlinedButton(
                                        onPressed: () async {
                                          //ToDo: add apply to job functionality.
                                          homeController
                                              .applyToAJob(homeController
                                                  .jobPosts[index].jobId)
                                              .then((value) {
                                            if (value.data.isNotEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Succesfully applied to ${homeController.jobPosts[index].companyName}')));
                                            }
                                          });
                                        },
                                        child: const Text('Apply'))
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: homeController.jobPosts.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'My Drives',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      homeController.appliedJobs.isNotEmpty ?
                      SizedBox(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            itemBuilder: (ctx, index) {
                              return FutureBuilder(
                                  future: AppWriteDb.getJobById(homeController.appliedJobs[index]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      final JobPost job = snapshot.data;
                                      return ListTile(title: Text(job.companyName),);
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text('An error occurred!'));
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  });
                            },
                            separatorBuilder: (ctx, index) {
                              return SizedBox(height: 10,);
                            },
                            itemCount: homeController.appliedJobs.length),
                      ) : Container()
                    ],
                  ),
                );
        }));
  }
}
