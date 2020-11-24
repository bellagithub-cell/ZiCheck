import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'insertdiagnosa.dart';

class DetailCheckup extends StatefulWidget {
  DetailCheckup({Key key, this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _DetailChekupState createState() => _DetailChekupState();
}

class _DetailChekupState extends State<DetailCheckup> {
  @override
  Widget build(BuildContext context) {
    final buttonhasil = Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 7, 8),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertDiagnosa()),
                );
              },
              tooltip: 'Toggle',
              child: Icon(Icons.create)),
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Checkup"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text(
                "Detail Checkup",
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      widget.data['date_checkup'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  // ListTile(
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Suhu Tubuh         : " +
                          widget.data['body_temp'] +
                          " Derajat",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                    //   contentPadding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Tekanan Darah    : " +
                          widget.data['blood_press_sis'] +
                          "/" +
                          widget.data['blood_press_dias'] +
                          " mmHg",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Detak Jantung    : " +
                          widget.data['heart_rate'] +
                          " BPM",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Stress level         : " + widget.data['stress_level'],
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(color: Colors.black),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Nama                  : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 15, 10),
                    child: Text(
                      widget.data['nama_depan'] +
                          " " +
                          widget.data['nama_blkg'],
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Jenis Kelamin    : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 15, 10),
                    child: Text((() {
                      if (widget.data['jenis_kelamin'] == "L") {
                        return "Laki-Laki";
                      } else {
                        return "Perempuan";
                      }
                    })()),
                  ),
                  buttonhasil,
                ],
              ),
            ),
          ],
        ));
    // throw UnimplementedError();
  }
}
