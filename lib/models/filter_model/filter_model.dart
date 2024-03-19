import 'package:flutter/material.dart';

class Filter{
  String? jobId;
  int? currentSemester;
  double? CGPA;
  String? branch;
  String? yearOfGraduation;
  int? activeBackLogs;
  int? totalBackLogs;
  double? XIIMarks;
  double? diplomaMarks;
  double? XMarks;

  Filter({
    this.jobId,
    this.currentSemester,
    this.CGPA,
    this.branch,
    this.yearOfGraduation,
    this.activeBackLogs,
    this.totalBackLogs,
    this.XIIMarks,
    this.diplomaMarks,
    this.XMarks
  });

  factory Filter.fromJson(Map<String, dynamic> json, String jobId){
    return Filter(
        jobId: jobId,
        currentSemester: json['currentSemester'] ?? 1,
        CGPA: json['CGPA'] ?? 1.0,
        branch: json['branch'] ?? '',
        yearOfGraduation: json['yearOfGraduation'] ?? '',
        activeBackLogs: json['activeBackLogs'] ?? 0,
        totalBackLogs: json['totalBackLogs'] ?? 0,
        XIIMarks: json['XIIMarks'] ?? 0.0,
        diplomaMarks: json['diplomaMarks'] ?? 0.0,
        XMarks: json['XMarks'] ?? 0.0
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'currentSemester': currentSemester ?? 1,
      'CGPA': CGPA ?? 1.0,
      'branch': branch ?? '',
      'yearOfGraduation': yearOfGraduation ?? '',
      'activeBackLogs': activeBackLogs ?? 0,
      'totalBackLogs': totalBackLogs ?? 0,
      'XIIMarks': XIIMarks ?? 0.0,
      'diplomaMarks': diplomaMarks ?? 0.0,
      'XMarks': XMarks ?? 0.0
    };
  }
}
