import 'package:flutter/material.dart';
import 'home.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  var dateCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String _valJenisKelamin; // untuk simpen value gender
    List _gender = ["Laki-laki", "Perempuan"];
    var mediaQueryData = MediaQuery.of(context);
    final double heightScreen = mediaQueryData.size.height / 15;
    DateTime _datePicked;

    final register = Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, heightScreen),
        child: RichText(
            text: TextSpan(
                text: "Register",
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
          hintText: "Alamat Rumah",
          labelText: "Alamat Rumah",
          prefixIcon: Icon(Icons.location_on),
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
          prefixIcon: Icon(Icons.phone),
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
          prefixIcon: Icon(Icons.email),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
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
    );

    final confirmpasswordField = TextField(
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Konfirmasi Sandi",
          prefixIcon: Icon(Icons.vpn_key),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
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
