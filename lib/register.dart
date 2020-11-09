import 'package:flutter/material.dart';

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

    final jenisKelamin = DropdownButtonFormField(
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
      keyboardType: TextInputType.datetime,
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
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nomor Handphone",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final emailField = TextField(
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Login()),
          // );
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
    );
    // throw UnimplementedError();
  }
}
