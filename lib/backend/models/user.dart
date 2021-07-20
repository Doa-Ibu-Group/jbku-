//fpr auth -nqb
//@dart=2.9
class User {
  final String uid;
  User({this.uid});
}

class UserInformation {
  final String uid;
  final String fullname;
  final String location;
  final String nric;
  final String username;
  final String role;
  final String pictUrl;
  UserInformation(
      {this.uid,
      this.fullname,
      this.location,
      this.nric,
      this.username,
      this.role,
      this.pictUrl});
}
