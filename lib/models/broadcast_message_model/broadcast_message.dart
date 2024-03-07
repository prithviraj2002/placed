import 'package:flutter/material.dart';

class BroadcastMessage{
  String message;
  String date;
  String time;
  String jobId;

  BroadcastMessage({
    required this.message,
    required this.date,
    required this.time,
    required this.jobId,
  });

  factory BroadcastMessage.fromJson(Map<String, dynamic> json){
    return BroadcastMessage(message: json['message'], date: json['date'], time: json['time'], jobId: json['jobId']);
  }

  Map<String, dynamic> toMap(){
    return {
      'message': message,
      'date': date,
      'time': time,
      'jobId': jobId,
    };
  }
}