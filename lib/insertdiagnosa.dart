import 'package:flutter/material.dart';
import 'dokter.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'global.dart' as global;

class InsertDiagnosa extends StatefulWidget {
  @override
  _InsertDiagnosa createState() => _InsertDiagnosa();
}

class _InsertDiagnosa extends State<InsertDiagnosa> {
  final _key = new GlobalKey<FormState>();
  List data;
  String id;
  var value;
  bool visible = false;

  //controller masing-masing kecuali tgl lahir sama jenis kelamin
  var diagnoseController = TextEditingController();
  var medicineController = TextEditingController();
  var idcheckupController = TextEditingController();

  // dapetin id user
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("iddok");
      // value = preferences.getInt("value");
      // id = value;
      debugPrint(id);
      // user();
    });
  }

  // ambil data user sesuai id
  user() async {
    final response = await http
        .post(global.ipServer + "/flutter/user.php", //ganti sesuai komputer masing2
            body: {
          "id": id,
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    int value = data['value'];
    String pesan = data['message'];
  }

  //cek validasi
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      debugPrint("ini controller diagnose :" + diagnoseController.text);
      debugPrint("ini controller medicine :" + medicineController.text);
      debugPrint("ini controller id_checkup: " + idcheckupController.text);
      insertdata();
    }
  }

  insertdata() async {
    debugPrint("masuk pak eko");
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print("now: " + formattedDate); // 2016-01-25
    print("id : " + id);
    final response = await http.post(
        global.ipServer + "/insertdiagnose.php", //ganti sesuai komputer masing2
        body: {
          "diagnosa": diagnoseController.text,
          "obat": medicineController.text,
          "id_dokter": id,
          "date_hasil": formattedDate,
          "id_checkup": idcheckupController.text,
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    // loadprogress();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Dokter()));
  }

  loadprogress() {
    if (visible == true) {
      // buat loading UI yg muter2
      setState(() {
        visible = false;
        // Future.delayed(Duration(seconds: 5), () {
        //   debugPrint('Step 1, fetch data');
        //   return false;
      });
      // });
    } else {
      setState(() {
        visible = true;
      });
    }
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
    // TODO: implement build
    var mediaQueryData = MediaQuery.of(context);
    final double heightScreen = mediaQueryData.size.height / 15;

    final diagnose = TextField(
      obscureText: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Diagnose",
          labelText: "Diagnose",
          prefixIcon: Icon(Icons.medical_services),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: diagnoseController,
    );

    final medicine = TextField(
      obscureText: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Medicine",
          labelText: "Medicine",
          prefixIcon: Icon(Icons.medical_services_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: medicineController,
    );

    final idcheckup = TextFormField(
      obscureText: false,
      //tampilan
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "ID Checkup",
          labelText: "ID Checkup",
          prefixIcon: Icon(Icons.vpn_key),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: idcheckupController,
    );

    final editprofile = Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, heightScreen),
        child: RichText(
            text: TextSpan(
                text: "Form Insert Diagnose",
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 50,
                  color: Colors.blue,
                ))));

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          check();
          // loadprogress();
        },
        child: Text("Save",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Insert Diagnose"),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _key,
                child: Container(
                  child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            editprofile,
                            SizedBox(height: 15.0),
                            diagnose,
                            SizedBox(height: 15.0),
                            medicine,
                            SizedBox(height: 15.0),
                            idcheckup,
                            SizedBox(height: 15.0),
                            saveButton,
                            Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: visible,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ])),
                ))));
    // throw UnimplementedError();
  }
}
