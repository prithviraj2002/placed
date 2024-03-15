class AppWriteStrings{
  static const String endPoint = 'https://cloud.appwrite.io/v1';
  static const String projectId = '659f955654db1b66e4b6';

  //Database
  static const String dbID = '65ab73cee9265f8b049b';
  static const String profileCollectionsId = '65ab73eec953f243cdac';
  static const String jobsCollectionId = '65ad06fdc3b55e37ae8b';
  static const String broadcastCollectionId = '65aca87fbf43f6aef2bb';

  //Storage
  static const String imageBucketId = '65b35832b94925a129da';
  static const String resumeBucketId = '65b108a4e427ecd7669c';
  static const String deptBucketId = '65e59e475d2b35953495';

  //urls
  static const String resumeViewUrl = '$endPoint/storage/buckets/$resumeBucketId/files/65d843736885561b6a1d/view?project=$projectId&mode=admin';
  static const String imageViewUrl = '$endPoint/storage/buckets/$imageBucketId/files/65d843736885561b6a1d/view?project=$projectId&mode=admin';
}