//fpr auth -nqb
//@dart=2.9
class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String titleOfReport;
  final String reportDescription;
  final String reportCategory;

  UserData(
      {this.uid,
      this.name,
      this.titleOfReport,
      this.reportDescription,
      this.reportCategory});
}

class UserInformation {
  final String uid;
  final String fullname;
  final String location;
  final String nric;
  final String username;

  UserInformation(
      {this.uid, this.fullname, this.location, this.nric, this.username});
}
