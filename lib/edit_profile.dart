import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'global.dart' as global;

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _key = new GlobalKey<FormState>();
  List data;
  String id;
  var value;
  String namad;
  String namab;
  String nohp;
  String alamatrmh;
  String email;
  bool visible = false;

  //controller masing-masing kecuali tgl lahir sama jenis kelamin
  var namaDepanController = TextEditingController();
  var namaBlkgController = TextEditingController();
  var alamatRmhController = TextEditingController();
  var noHpController = TextEditingController();
  var emailController = TextEditingController();

  // dapetin id user
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
    this.namad = data['hasil']['nama_depan'];
    this.namab = data['hasil']['nama_blkg'];
    this.nohp = data['hasil']['no_hp'];
    this.alamatrmh = data['hasil']['alamat_rmh'];
    this.email = data['hasil']['email'];

    //controller masing-masing kecuali tgl lahir sama jenis kelamin
    namaDepanController.text = namad;
    namaBlkgController.text = namab;
    noHpController.text = nohp;
    alamatRmhController.text = alamatrmh;
    emailController.text = email;
  }

  //cek validasi
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      debugPrint("ini controller nama Depan :" + namaDepanController.text);
      debugPrint("ini controller nama Belakang :" + namaBlkgController.text);
      debugPrint("ini controller alamat rumah :" + alamatRmhController.text);
      debugPrint("ini controller no hp :" + noHpController.text);
      debugPrint("ini controller email :" + emailController.text);
      updatedata();
    }
  }

  updatedata() async {
    debugPrint("masuk pak eko");
    final response = await http
        .post(global.ipServer + "/flutter/update.php", //ganti sesuai komputer masing2
            body: {
          "nama_depan": namaDepanController.text,
          "nama_blkg": namaBlkgController.text,
          "alamat": alamatRmhController.text,
          "no_hp": noHpController.text,
          "email": emailController.text,
          "id_user": id,
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    // loadprogress();
    Navigator.pop(context, true);
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

    final namaDepan = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          labelText: "First Name",
          prefixIcon: Icon(Icons.supervised_user_circle),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: namaDepanController,
    );

    final namaBelakang = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          labelText: "Last Name",
          prefixIcon: Icon(Icons.supervised_user_circle),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: namaBlkgController,
    );

    final alamatRumah = TextField(
      obscureText: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Address",
          labelText: "Address",
          prefixIcon: Icon(Icons.location_on),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: alamatRmhController,
    );

    final nomorHandphone = TextField(
      obscureText: false,
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone Number",
          prefixIcon: Icon(Icons.phone),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: noHpController,
    );

    final emailField = TextField(
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: emailController,
    );

    final editprofile = Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, heightScreen),
        child: RichText(
            text: TextSpan(
                text: "Form Edit Profile",
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
          title: Text("Edit Profile"),
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
                            namaDepan,
                            SizedBox(height: 15.0),
                            namaBelakang,
                            SizedBox(height: 15.0),
                            alamatRumah,
                            SizedBox(height: 15.0),
                            nomorHandphone,
                            SizedBox(height: 15.0),
                            emailField,
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
