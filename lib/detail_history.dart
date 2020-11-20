import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailHistory extends StatefulWidget {
  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  // buat ambil id dari share preference
  String id;
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      // value = preferences.getInt("value");
      // id = value;
      debugPrint(id);
      user();
    });
  }

  user() async {
    final response = await http.post(
        "http://192.168.43.47/historydetail.php", //ganti sesuai komputer masing2
        body: {
          "id": id,
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    for (var i = 0; i < data['hasil'].length; i++) {}
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Riwayat"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text(
                "Detail Riwayat Checkup",
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
                      "20 November 2019",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  // ListTile(
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Suhu Tubuh : " + "38" + " Derajat",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                    //   contentPadding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Tekanan Darah : " + "120/80" + " mmHg",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Detak Jantung : " + "40" + " BPM",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Stress level : " + "5",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(color: Colors.black),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Diagnosa : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 15, 10),
                    child: Text(
                      "Penyakit Jantung Koroner disertai efek samping yaitu Diabetes",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Text(
                      "Obat : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 15, 10),
                    child: Text(
                      "Aspilet 10 Butir, 2x Sehari \nInsulin, sebelum makan",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
    // throw UnimplementedError();
  }
}
