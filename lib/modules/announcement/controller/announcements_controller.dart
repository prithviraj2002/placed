import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:placed_mobile_app/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_mobile_app/appwrite/appwrite_strings.dart';
import 'package:placed_mobile_app/models/broadcast_message_model/broadcast_message.dart';
import 'package:placed_mobile_app/modules/home_module/controller/home_controller.dart';

class AnnouncementController extends GetxController{

  HomeController homeController = Get.find<HomeController>();

  RxList<BroadcastMessage> allBroadcastMessages = <BroadcastMessage>[].obs;
  RxList<BroadcastMessage> broadCastMessages = <BroadcastMessage>[].obs;

  late StreamSubscription<RealtimeMessage> subscription;
  RxMap<String, RxList<BroadcastMessage>> relevantMessages = <String, RxList<BroadcastMessage>>{'' : <BroadcastMessage>[].obs}.obs;


  @override
  void onInit(){
    super.onInit();
    getAllMessages();
    listenToBroadcastMessages();
  }

  Future<void> getAllMessages() async{
    allBroadcastMessages.value = await AppWriteDb.getBroadcastMessages();
    getRelevantMessages();
  }

  List<BroadcastMessage> getMessageListById(String id){
    return relevantMessages[id] ?? [BroadcastMessage(message: 'message', date: 'date', time: 'time', jobId: 'jobId')];
  }

  BroadcastMessage getLatestMessage(String id){
    List<BroadcastMessage> msgList = getMessageListById(id);
    return msgList.last;
  }

  void getRelevantMessages(){
    RxList<dynamic> appliedJobs = homeController.appliedJobs;
    for (var id in appliedJobs) {
      RxList<BroadcastMessage> msgList = <BroadcastMessage>[].obs;
      for (BroadcastMessage msg in allBroadcastMessages) {
        if (msg.jobId == id) {
          msgList.add(msg);
        }
      }
      relevantMessages['$id'] = msgList;
    }
  }
  
  void listenToBroadcastMessages(){
      final realtime = Realtime(AppWriteDb.client);
      subscription = realtime
          .subscribe([
        "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.broadcastCollectionId}.documents"
      ])
          .stream
          .listen((event) {
        if (event.events.contains(
            "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.broadcastCollectionId}.documents.*.create")) {
          final String title = event.payload['message'];
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: 10,
                  channelKey: 'basic_channel',
                  title: title,
                wakeUpScreen: true,
                fullScreenIntent: true
              )
          );
          getAllMessages().then((value) {
            getRelevantMessages();
          });
        } else if (event.events.contains(
            "databases.${AppWriteStrings.dbID}.collections.${AppWriteStrings.broadcastCollectionId}.documents.*.delete")) {
          getAllMessages().then((value) {
            getRelevantMessages();
          });
        }
      });
  }

  void stopListeningToMessages() {
    subscription.cancel();
  }
}