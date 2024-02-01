class JobPost{
  final String jobId;
  final String companyName;
  final String? description;
  final List<dynamic> positionsOffered;
  final List<dynamic> package;
  final DateTime endDate;
  final List<dynamic> filters;

  JobPost({
    required this.jobId,
    required this.companyName,
    this.description,
    required this.positionsOffered,
    required this.package,
    required this.endDate,
    required this.filters,
  });

  factory JobPost.fromJson(Map<String, dynamic> json){
    return JobPost(
        jobId: json['jobId'],
        companyName: json['companyName'],
        description: json['description'] ?? '',
        positionsOffered: json['positionsOffered'],
        package: json['package'],
        endDate: DateTime.parse(json['endDate']),
        filters: json['filters']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'jobId': jobId,
      'companyName': companyName,
      'description': description ?? '',
      'positionsOffered': positionsOffered,
      'package': package,
      'endDate': endDate,
      'filters': filters
    };
  }
}