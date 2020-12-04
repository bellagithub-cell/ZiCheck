import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dokter.dart';
import 'global.dart' as global;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

//status udah login atau belom
enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  LoginStatus _loginStatus = LoginStatus.notSignIn;
  //String email, password;
  final _key = new GlobalKey<FormState>();

  //cek validasi
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      debugPrint('debug : email: ' + emailController.text);
      debugPrint('debug : pass: ' + passController.text);
      login();
    }
  }

  // login ke mysql
  login() async {
    debugPrint('debug : masuk pak Eko');
    // nanya dia dokter bukan
    String temp = emailController.text;
    String cekdokter = emailController.text.substring(temp.length - 11);
    String url;
    print("substring : " + cekdokter);
    if (cekdokter == "@dokter.com") {
      url = global.ipServer +
          "/flutter/logindokter.php"; //ganti sesuai komputer masing2
    } else {
      url = global.ipServer +
          "/flutter/login.php"; //ganti sesuai komputer masing2
    }
    final response = await http.post(url, body: {
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
      debugPrint(id);

      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, namadAPI, namabAPI, id, iddok);
      });
      print(pesan);
      debugPrint('debug : masuk pak Eko 1');
      if (cekdokter == '@dokter.com') {
        Widget cekButton = FlatButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Dokter()),
                      (Route<dynamic> route) => false
              );
            },
            child: Icon(Icons.check));

        //bikin alert
        AlertDialog alert = AlertDialog(
          title: Text("Login Berhasil"),
          content: Text(
            "Login berhasil sebagai dokter" + emailAPI,
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
        //bikin button buat alert
        Widget cekButton = FlatButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false);
            },
            child: Icon(Icons.check));

        //bikin alert
        AlertDialog alert = AlertDialog(
          title: Text("Login Berhasil"),
          content: Text(
            "Login berhasil sebagai " + emailAPI,
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
      }
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
        title: Text("Login Gagal"),
        content: Text(
          "Email atau password salah",
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

  //ini tampilan
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double heightScreen = mediaQueryData.size.height / 7;

    final logo = Padding(
        padding: EdgeInsets.fromLTRB(0, heightScreen, 0, heightScreen),
        child: RichText(
            text: TextSpan(
                text: "ZiCheck",
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 50,
                  color: Colors.blue,
                ))));

    final emailField = TextFormField(
      obscureText: false,
      //tampilan
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          labelText: "Email",
          prefixIcon: Icon(Icons.email),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      //mastiin diisi
      validator: (e) {
        if (e.isEmpty) {
          return "Please insert email";
        }
      },
      //nama pas disimpen
      controller: emailController,
    );

    final passwordField = TextFormField(
      obscureText: true,
      //tampilan
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          labelText: "Password",
          prefixIcon: Icon(Icons.vpn_key),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: passController,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          check();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logo,
                    //untuk email
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 35.0),
                    loginButton,
                    SizedBox(height: 15.0),
                    // Text('Click button to back to Main Page'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // throw UnimplementedError();
  }
}
