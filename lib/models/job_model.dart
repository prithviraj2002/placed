class JobPost{
  final String companyName;
  final String? description;
  final String jobId;
  final String positionOffered;
  final List<dynamic> package;
  final String endDate;
  final String jobType;
  final String jobLocation;
  final List<dynamic> filters;

  JobPost({
    required this.companyName,
    this.description,
    required this.jobId,
    required this.positionOffered,
    required this.package,
    required this.endDate,
    required this.jobType,
    required this.jobLocation,
    required this.filters,
  });

  factory JobPost.fromJson(Map<String, dynamic> json, String jobId){
    return JobPost(
      companyName: json['companyName'],
      description: json['description'],
      jobId: jobId,
      positionOffered: json['positionOffered'],
      package: json['package'],
      endDate: json['endDate'],
      jobType: json['jobType'],
      jobLocation: json['jobLocation'],
      filters: json['filters'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'companyName': companyName,
      'description': description,
      'jobId': jobId,
      'positionOffered': positionOffered,
      'package': package,
      'endDate': endDate,
      'jobType': jobType,
      'jobLocation': jobLocation,
      'filters': filters,
    };
  }

  List<String> toList(){
    return [
      companyName,
      description ?? '',
      jobId,
    ];
  }
}