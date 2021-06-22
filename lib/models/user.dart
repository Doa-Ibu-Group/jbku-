//fpr auth -nqb
class User {
  final String uid;
  User({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String titleOfReport;
  final String reportDescription;
  final String reportCategory;

  UserData(
      {required this.uid,
      required this.name,
      required this.titleOfReport,
      required this.reportDescription,
      required this.reportCategory});
}

class UserInformation {
  final String uid;
  final String fullname;
  final String location;
  final String nric;
  final String username;

  UserInformation(
      {required this.uid,
      required this.fullname,
      required this.location,
      required this.nric,
      required this.username});
}
