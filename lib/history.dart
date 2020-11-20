import 'package:flutter/material.dart';
import 'detail_history.dart';
import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:shared_preferences/shared_preferences.dart';
import 'sidemenu.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  static const _GET_ALL_ACTION = 'GET_ALL';
  var arid = [];
  var ardate = [];
  var arstatus = [];
  int length;
  // List history = [];

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
        "http://192.168.43.47/history.php", //ganti sesuai komputer masing2
        body: {
          "id": id,
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    print(['hasil'].length.toInt());
    print(length);
    // for (var i = 0; i < length; i++) {
    //   arid[i] = data['hasil'][i]['id_checkup'];
    //   ardate[i] = data['hasil'][i]['date_checkup'];
    //   arstatus[i] = data['hasil'][i]['status'];
    // }
    // debugPrint(arid[0].toString());
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getPref();
    });
  }

  Future<bool> fetchData() => Future.delayed(Duration(seconds: 5), () {
        debugPrint('Step 1, fetch data');
        return true;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("History"),
        ),
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Text(
                      "Riwayat Checkup",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // ListView.builder(
                  //   itemCount: arid.length,
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  //       child: Text(
                  //         "Riwayat Checkup",
                  //         style: TextStyle(fontSize: 30),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     );
                  //   },
                  // ),
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    // throw UnimplementedError();
  }
}
