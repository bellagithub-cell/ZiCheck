import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'global.dart' as global;

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  var dateCtl = TextEditingController();

  //controller masing-masing kecuali tgl lahir sama jenis kelamin
  final namaDepanController = TextEditingController();
  final namaBlkgController = TextEditingController();
  final alamatRmhController = TextEditingController();
  final noHpController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();
  String _valJenisKelamin; // untuk simpen value gender
  String valJenisKlmn;

  //String email, password;

  final _key = new GlobalKey<FormState>();

  //cek validasi
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      debugPrint("ini controller nama Depan :" + namaDepanController.text);
      debugPrint("ini controller nama Belakang :" + namaBlkgController.text);
      debugPrint("ini controller tanggal :" + dateCtl.text);
      debugPrint("ini controller alamat rumah :" + alamatRmhController.text);
      debugPrint("ini controller no hp :" + noHpController.text);
      debugPrint("ini controller email :" + emailController.text);
      debugPrint("ini controller pass :" + passController.text);
      debugPrint("ini controller confirm password :" + confPassController.text);
      debugPrint("ini controller jenis_klmn :" + _valJenisKelamin);
      if (passController.text == confPassController.text) {
        registerUser();
      } else {
        Widget cekButton = FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"));

        //bikin alert
        AlertDialog alert = AlertDialog(
          title: Text("Register Gagal"),
          content: Text(
            "Password tidak sama",
            textAlign: TextAlign.justify,
          ),
          actions: [cekButton],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
          //barrierDismissible: false,
        );
      }
    }
  }

  registerUser() async {
    if (_valJenisKelamin == "Laki-laki") {
      valJenisKlmn = "L";
    } else {
      valJenisKlmn = 'P';
    }
    debugPrint("masuk pak eko");
    final response = await http
        .post(global.ipServer + "/flutter/register.php", //ganti sesuai komputer masing2
            body: {
          "nama_depan": namaDepanController.text,
          "nama_blkg": namaBlkgController.text,
          "jenis_klmn": valJenisKlmn,
          "tgl_lahir": dateCtl.text,
          "alamat": alamatRmhController.text,
          "no_hp": noHpController.text,
          "email": emailController.text,
          "password": passController.text
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      String emailAPI = data['hasil']['email'];
      String namadAPI = data['hasil']['nama_depan'];
      String namabAPI = data['hasil']['nama_blkg'];
      //simpen id dokter
      // print(data['hasil']['id_dokter']);
      String iddok = data['hasil']['id_dokter'];
      String id = data['hasil']['id_user'];
      setState(() {
        //_loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, namadAPI, namabAPI, id, iddok);
      });
      print(pesan);
      debugPrint('debug : masuk pak Eko 1');

      Widget cekButton = FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Icon(Icons.check));

      //bikin alert
      AlertDialog alert = AlertDialog(
        title: Text("Login Berhasil"),
        content: Text(
          "Masuk sebagai " + emailAPI,
          textAlign: TextAlign.justify,
        ),
        actions: [cekButton],
      );

      //nampilin alertnya
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
        barrierDismissible: false,
      );
    } else {
      print(pesan);
      debugPrint('debug : masuk pak Eko 2');
      Widget cekButton = FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"));

      //bikin alert
      AlertDialog alert = AlertDialog(
        title: Text("Register Gagal"),
        content: Text(
          "Email atau password tidak bisa digunakan",
          textAlign: TextAlign.justify,
        ),
        actions: [cekButton],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
        //barrierDismissible: false,
      );
    }
  }

  //disimpen ke Shared Preferences
  savePref(int value, String email, String namad, String namab, String id,
      String iddok) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("namad", namad);
      preferences.setString("namab", namab);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.setString("iddok", iddok);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    List _gender = ["Laki-laki", "Perempuan"];
    var mediaQueryData = MediaQuery.of(context);
    final double heightScreen = mediaQueryData.size.height / 15;
    DateTime _datePicked;

    final register = Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, heightScreen),
        child: RichText(
            text: TextSpan(
                text: "ZiCheck",
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 50,
                  color: Colors.blue,
                ))));

    final namaDepan = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nama Depan",
          labelText: "Nama Depan",
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
          hintText: "Nama Belakang",
          labelText: "Nama Belakang",
          prefixIcon: Icon(Icons.supervised_user_circle),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: namaBlkgController,
    );

    final jenisKelamin = DropdownButtonFormField(
      hint: Text("Pilih Jenis Kelamin"),
      style: TextStyle(
          fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black),
      value: _valJenisKelamin,
      items: _gender.map((value) {
        return DropdownMenuItem(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (value) {
        // setState(() {
        _valJenisKelamin = value;
        // });
      },
    );

    Future<Null> _showDatePicker(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now());
      if (picked != null && picked != DateTime.now()) {
        print("hallloooo $picked");
        setState(() {
          _datePicked = picked;
          dateCtl.text = "${_datePicked.toLocal()}".split(' ')[0];
          print(dateCtl.text);
        });
      }
    }

    final tanggalLahir = GestureDetector(
        child: TextFormField(
            obscureText: false,
            controller: dateCtl,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                // hintText: "Tanggal Lahir",
                labelText: "Tanggal Lahir",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0))),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _showDatePicker(context);
              dateCtl.text = "${_datePicked.toLocal()}".split(' ')[0];
            }));

    final alamatRumah = TextField(
      obscureText: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Alamat",
          labelText: "Alamat",
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
          hintText: "Nomor Hp",
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

    final passwordField = TextField(
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Kata Sandi",
          prefixIcon: Icon(Icons.vpn_key),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: passController,
    );

    final confirmpasswordField = TextField(
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Konfirmasi Kata Sandi",
          prefixIcon: Icon(Icons.vpn_key),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: confPassController,
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          check();
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );*/
        },
        child: Text("Daftar",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
        backgroundColor: Colors.blueAccent,
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
                  register,
                  //untuk email
                  SizedBox(height: 15.0),
                  namaDepan,
                  SizedBox(height: 15.0),
                  namaBelakang,
                  SizedBox(height: 15.0),
                  jenisKelamin,
                  SizedBox(height: 15.0),
                  tanggalLahir,
                  SizedBox(height: 15.0),
                  alamatRumah,
                  SizedBox(height: 15.0),
                  nomorHandphone,
                  SizedBox(height: 15.0),
                  emailField,
                  SizedBox(height: 15.0),
                  passwordField,
                  SizedBox(height: 15.0),
                  confirmpasswordField,
                  SizedBox(height: 15.0),
                  registerButton,
                  SizedBox(height: 15.0),
                  // Text('Click button to back to Main Page'),
                  // RaisedButton(
                  //   textColor: Colors.white,
                  //   color: Colors.redAccent,
                  //   child: Text('Back to Main Page'),
                  //   onPressed: () {
                  //
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // throw UnimplementedError();
  }
}
