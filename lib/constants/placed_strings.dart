class PlacedStrings{
  static const String completeYourProfile = 'Complete Profile';
  static const String personal = "Personal";
  static const String education = "Educational";
  static const String resume = "Resume";
  static List<String> branchOption(){
    List<String> options = [
      "Computer Science Engineering(CSE)",
      "Computer Engineering(CE)",
      "Information Technology(IT)",
    ];
    return options;
  }
  static List<String> degreeOption(){
    List<String> options = [
      "B.Tech",
    ];
    return options;
  }
  static List<String> GenderOption(){
    List<String> options = [
      "Male",
      "Female",
      "Other",
      "Prefer not to describe",
    ];
    return options;
  }
}