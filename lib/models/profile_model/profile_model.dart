import 'package:uuid/uuid.dart';

class Profile {
  String name;
  String id;
  String email;
  String dateOfBirth;
  String IU;
  String phoneNumber;
  String course;
  String degree;
  int year;
  int sem;
  double XMarks;
  String XPassingYear;
  double? XIIMarks;
  String? XIIPassingYear;
  String? diplomaBranch;
  String? diplomaPassingYear;
  double? diplomaMarks;
  String gender;
  String board;
  String engYearOfPassing;
  double cgpa;
  int activeBackLog;
  int totalBackLog;
  String address;
  List<String>? appliedJobs;
  String? githubProfile;
  String? linkedinProfile;
  String? otherLink;
  bool status;

  Profile({
    required this.name,
    required this.id,
    required this.email,
    required this.dateOfBirth,
    required this.IU,
    required this.phoneNumber,
    required this.course,
    required this.degree,
    required this.year,
    required this.sem,
    required this.XMarks,
    required this.XPassingYear,
    this.XIIMarks,
    this.XIIPassingYear,
    this.diplomaBranch,
    this.diplomaPassingYear,
    this.diplomaMarks,
    required this.gender,
    required this.board,
    required this.engYearOfPassing,
    required this.cgpa,
    required this.activeBackLog,
    required this.totalBackLog,
    required this.address,
    this.appliedJobs,
    this.githubProfile,
    this.linkedinProfile,
    this.otherLink,
    required this.status,
  });

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(name: json['name'],
        id: json['id'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'],
        IU: json['IU'],
        phoneNumber: json['IU'],
        course: json['IU'],
        degree: json['degree'],
        year: json['year'],
        sem: json['sem'],
        XMarks: json['XMarks'],
        XPassingYear: json['XPassingYear'],
        XIIMarks: json['XIIMarks'] ?? '',
        XIIPassingYear: json['XIIPassingYear'] ?? '',
        diplomaBranch: json['diplomaBranch'] ?? '',
        diplomaMarks: json['diplomaMarks'] ?? 0.0,
        diplomaPassingYear: json['diplomaPassingYear'] ?? '',
        gender: json['gender'],
        board: json['board'],
        engYearOfPassing: json['engYearOfPassing'],
        cgpa: json['cgpa'],
        activeBackLog: json['activeBackLog'],
        totalBackLog: json['totalBackLog'],
        address: json['address'],
      appliedJobs: json['appliedJobs'],
      linkedinProfile: json['linkedinProfile'],
      githubProfile: json['githubProfile'],
      otherLink: json['otherLink'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'IU': IU,
      'phoneNumber': phoneNumber,
      'course': course,
      'degree': degree,
      'year': year,
      'sem': sem,
      'XMarks': XMarks,
      'XPassingYear': XPassingYear,
      'gender': gender,
      'board': board,
      'engYearOfPassing': engYearOfPassing,
      'cgpa': cgpa,
      'activeBackLog': activeBackLog,
      'totalBackLog': totalBackLog,
      'address': address,
      'XIIMarks' : XIIMarks ?? 0.0,
      'XIIPassingYear' : XIIPassingYear ?? 0.0,
      'diplomaBranch' : diplomaBranch ?? '',
      'diplomaPassingYear': diplomaPassingYear ?? '',
      'diplomaMarks': diplomaMarks ?? 0.0,
      'appliedJobs' : appliedJobs ?? [],
      'linkedinProfile': linkedinProfile,
      'githubProfile': githubProfile,
      'otherLink': otherLink,
      'status': status,
    };
  }

}