import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZiCheck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ZiCheck'),
    );
  }
}

//status udah login atau belom
enum LoginStatus { notSignIn, signIn }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  // int _counter = 0;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final linkLogin = RichText(
      text: TextSpan(
          text: "Masuk/Login",
          style: TextStyle(
              fontFamily: 'Monserrat',
              fontSize: 25,
              color: Colors.red,
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            }),
    );

    final linkRegister = RichText(
      text: TextSpan(
          text: "Daftar/Signup",
          style: TextStyle(
              fontFamily: 'Monserrat',
              fontSize: 25,
              color: Colors.red,
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            }),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Container(

          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  linkLogin,
                  linkRegister,
                ],
              )),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  final emailController = TextEditingController();
  final passController = TextEditingController();

  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      debugPrint('debug : email: '+emailController.text);
      debugPrint('debug : pass: '+passController.text);
      login();
    }
  }

  // login ke mysql
  login() async {
    debugPrint('debug : masuk pak Eko');
    final response = await http.post("http://192.168.2.103/flutter/login.php",//ganti sesuai komputer masing2
        body: {"email": emailController.text, "password": passController.text}).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : '+response.body);
    int value = data['value'];
    String pesan = data['message'];
    String emailAPI = data['email'];
    String namaAPI = data['nama'];
    String id = data['id'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, namaAPI, id);
      });
      print(pesan);
      debugPrint('debug : masuk pak Eko 1');
    } else {
      print(pesan);
      debugPrint('debug : masuk pak Eko 2');
    }
  }

  //disimpen ke Shared Preferences
  savePref(int value, String email, String nama, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  //ambil dari Shared Preferences
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  // signOut atau logOut
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  //ini tampilan
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      //tampilan
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      //mastiin diisi
      validator: (e){
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
      body: Form(
        key: _key,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //untuk email
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 35.0),
                loginButton,
                SizedBox(height: 15.0),
                Text('Click button to back to Main Page'),
              ],
            ),
          ),
        ),
      ),
    );
    // throw UnimplementedError();
  }
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _valJenisKelamin; // untuk simpen value gender
    List _gender = ["Laki-laki", "Perempuan"];
    final namaDepan = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nama Depan",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final namaBelakang = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nama Belakang",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final jenisKelamin = DropdownButton(
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

    final tanggalLahir = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Tanggal Lahir",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final alamatRumah = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Alamat Rumah",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final nomorHandphone = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nomor Handphone",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final emailField = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Kata Sandi",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final confirmpasswordField = TextField(
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Konfirmasi Sandi",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {

        },
        child: Text("Daftar",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                Text('Click button to back to Main Page'),
              ],
            ),
          ),
        ),
      ),
    );
    // throw UnimplementedError();
  }
}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page hhg'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                // TODO
              },
            )
          ],
        ),
      ),
    );
    // throw UnimplementedError();
  }
}
