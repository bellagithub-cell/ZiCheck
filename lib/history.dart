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
  String idcheckup;
  String date;
  List<String> arid = [];
  List<String> ardate = [];
  List<String> arstatus = [];
  List<Map<String, dynamic>> ardata = [];
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
    // print(data['hasil'].length.toInt());
    print("length : " + data['hasil'].length.toString());
    int pdata = data['hasil'].length.toInt();
    print("pdata is : " + pdata.toString());
    // print(data['hasil'][0].toString());
    for (var i = 0; i < pdata; i++) {
      // ardata.add(data['hasil'][i].toString());
      // arid.add(data['hasil'][i]['id_checkup']);
      // ardate.add(data['hasil'][i]['date_checkup']);
      // arstatus.add(data['hasil'][i]['status']);
      ardata.add(data['hasil'][i]);
    }
    debugPrint("data : " + ardata[0].toString());
    // debugPrint(ardate[0].toString());
    // debugPrint(arstatus[0].toString());
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
          title: Text("Riwayat Checkup"),
        ),
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: ardata.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white10),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.white24))),
                                  child:
                                      Icon(Icons.history, color: Colors.black),
                                ),
                                title: Text(
                                  ardata[index]['date_checkup'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: <Widget>[
                                    Icon(Icons.linear_scale,
                                        color: Colors.yellowAccent),
                                    Text(ardata[index]['status'],
                                        style: TextStyle(color: Colors.black))
                                  ],
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.black, size: 30.0),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailHistory(
                                                data: ardata[index],
                                              )));
                                },
                              ),
                            ),
                          );
                        }));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    // throw UnimplementedError();
  }
}
