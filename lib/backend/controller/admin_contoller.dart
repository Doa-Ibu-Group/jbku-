// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController {
  final String reportuid;

  AdminController({this.reportuid});
  final CollectionReference ref = Firestore.instance.collection("reports");

  Future addRespond(String respond) async {
    return await ref
        .document(reportuid)
        .updateData({
          'respond': respond,
        })
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }

  Future delete() async {
    return await ref.document(reportuid).delete();
  }
}
