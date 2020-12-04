import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zicheckk/dokter.dart';
import 'package:zicheckk/home.dart';
import 'package:zicheckk/login.dart';
import 'register.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    var value, namad, namab, email, id, iddok;

    getPref() async {
      debugPrint("masuk ke getPref");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        value = preferences.getInt("value");
        namad = preferences.getString("namad");
        namab = preferences.getString("namab");
        email = preferences.getString("email");
        id = preferences.getString("id");
        iddok = preferences.getString("iddok");
      });
      debugPrint("value = " + value.toString());
      debugPrint("namad = " + namad);
      debugPrint("namab = " + namab);
      debugPrint("email = " + email);
      debugPrint("id = " + id.toString());
      debugPrint("iddok = " + iddok.toString());
      if (value == 1) {
        debugPrint("masuk cuy");
        if (email.toString().contains("@dokter.com")) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dokter()),
                  (Route<dynamic> route) => false
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false
          );
        }
      }
    }

    getPref();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double heightScreen = mediaQueryData.size.height / 5;

    // untuk logo zichek
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

    // untuk link button buat login
    final linkloginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // link button buat register
    final linkregisterButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // cadangan aja, kalau mau pakai link bisa pakai ini
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
                  logo,
                  linkloginButton,
                  SizedBox(height: 10.0),
                  linkregisterButton,
                  // linkLogin,
                  // linkRegister,
                ],
              )),
        ),
      ),
    );
  }
}

// class Register extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String _valJenisKelamin; // untuk simpen value gender
//     List _gender = ["Laki-laki", "Perempuan"];
//     final namaDepan = TextField(
//       obscureText: false,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Nama Depan",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final namaBelakang = TextField(
//       obscureText: false,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Nama Belakang",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final jenisKelamin = DropdownButton(
//       style: TextStyle(
//           fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black),
//       value: _valJenisKelamin,
//       items: _gender.map((value) {
//         return DropdownMenuItem(
//           child: Text(value),
//           value: value,
//         );
//       }).toList(),
//       onChanged: (value) {
//         // setState(() {
//         _valJenisKelamin = value;
//         // });
//       },
//     );

//     final tanggalLahir = TextField(
//       obscureText: false,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Tanggal Lahir",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final alamatRumah = TextField(
//       obscureText: false,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Alamat Rumah",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final nomorHandphone = TextField(
//       obscureText: false,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Nomor Handphone",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final emailField = TextField(
//       obscureText: false,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Email",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final passwordField = TextField(
//       obscureText: true,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Kata Sandi",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final confirmpasswordField = TextField(
//       obscureText: true,
//       style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Konfirmasi Sandi",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
//     );

//     final registerButton = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(12.0),
//       color: Colors.blue,
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: () {},
//         child: Text("Daftar",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
//                 .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(36.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 //untuk email
//                 SizedBox(height: 15.0),
//                 namaDepan,
//                 SizedBox(height: 15.0),
//                 namaBelakang,
//                 SizedBox(height: 15.0),
//                 jenisKelamin,
//                 SizedBox(height: 15.0),
//                 tanggalLahir,
//                 SizedBox(height: 15.0),
//                 alamatRumah,
//                 SizedBox(height: 15.0),
//                 nomorHandphone,
//                 SizedBox(height: 15.0),
//                 emailField,
//                 SizedBox(height: 15.0),
//                 passwordField,
//                 SizedBox(height: 15.0),
//                 confirmpasswordField,
//                 SizedBox(height: 15.0),
//                 registerButton,
//                 SizedBox(height: 15.0),
//                 Text('Click button to back to Main Page'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     // throw UnimplementedError();
//   }
// }

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
