//@dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/backend/controller/admin_contoller.dart';
import 'package:jbku_project/share/constant.dart';

class Respond extends StatefulWidget {
  final String imgUrl;
  final String reportid;
  final String reportTitle;
  final String reportdateTime;
  final String reportCategory;
  final String reportDescription;
  final String respond;
  final String userid;
  Respond(
      {this.imgUrl,
      this.respond,
      this.reportid,
      this.reportCategory,
      this.reportDescription,
      this.reportTitle,
      this.reportdateTime,
      this.userid});

  @override
  _RespondState createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  final _formKey = GlobalKey<FormState>();
  String respond = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 400.0,
                  color: Colors.grey,
                  child: Image.network(widget.imgUrl),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' #${widget.reportid}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Category: ${widget.reportCategory}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Location: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Date And Time: ${widget.reportdateTime}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Description: ${widget.reportDescription}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' UserId: ${widget.userid}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  ' Current respond: ${widget.respond}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Respond goes here'),
                    validator: (value) =>
                        value.isEmpty ? 'Enter an Email' : null,
                    onChanged: (value) {
                      setState(() {
                        respond = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        print(respond);
                        await AdminController(reportuid: widget.userid)
                            .addRespond(respond);
                        Navigator.pop(context);
                      },
                      child: Text('Respond')),
                )
              ],
            ),
          ),
        ));
  }
}
