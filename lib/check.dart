import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';

void main() => runApp(Check());

class Check extends StatelessWidget {

  final _key = new GlobalKey<FormState>();
  final bodyTempController = TextEditingController();
  final sysBloodPressController = TextEditingController();
  final diasBloodPressController = TextEditingController();
  //final stressLevelController = TextEditingController();
  final breathComplaintController = TextEditingController();
  final consumeAntibioticController = TextEditingController();
  final allergiesController = TextEditingController();
  final otherComplaintController = TextEditingController();
  String _valStressLevel;

  @override
  Widget build(BuildContext context) {
    List _stressLevel = ["1. Tidak Stress", "2. Lumayan Stress","3. Cukup Stress","4. Panik/Sangat Stress"];
    var mediaQueryData = MediaQuery.of(context);
    final double heightScreen = mediaQueryData.size.height / 15;

    final checkUp = Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, heightScreen),
        child: RichText(
            text: TextSpan(
                text: "ZiCheck",
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 50,
                  color: Colors.blue,
                ))));

    final bodyTemp = TextField(
      obscureText: false,
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Suhu Tubuh",
          prefixIcon: Icon(Icons.phone),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: bodyTempController,
    );

    final sysBloodPress = TextField(
      obscureText: false,
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Tekanan Darah Sistolik",
          prefixIcon: Icon(Icons.phone),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: sysBloodPressController,
    );

    final diaBloodPressure = TextField(
      obscureText: false,
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Tekanan Darah Diatolik",
          prefixIcon: Icon(Icons.phone),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: diasBloodPressController,
    );

    final stressLevel = DropdownButtonFormField(
      style: TextStyle(
          fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black),
      value: _valStressLevel,
      items: _stressLevel.map((value) {
        return DropdownMenuItem(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (value) {
        // setState(() {
        _valStressLevel = value;
        // });
      },
    );

    final keluhanPernafasan = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Keluhan Pernafasan",
          labelText: "Keluhan Pernafasan",
          prefixIcon: Icon(Icons.supervised_user_circle),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: breathComplaintController,
    );

    final consumeAntibiotik = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Konsumsi Antibiotik",
          labelText: "Konsumsi Antibiotik",
          prefixIcon: Icon(Icons.supervised_user_circle),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: consumeAntibioticController,
    );

    final allergies = TextField(
      obscureText: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Alergi",
          labelText: "Alergi",
          prefixIcon: Icon(Icons.location_on),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: allergiesController,
    );

    final otherComplaint = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Keluhan lain",
          labelText: "Keluhan lain",
          prefixIcon: Icon(Icons.supervised_user_circle),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      controller: otherComplaintController,
    );

    final checkUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //check();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Text("Lanjut",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Check Up'),
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
                  checkUp,
                  //untuk email
                  SizedBox(height: 15.0),
                  bodyTemp,
                  SizedBox(height: 15.0),
                  sysBloodPress,
                  SizedBox(height: 15.0),
                  diaBloodPressure,
                  SizedBox(height: 15.0),
                  stressLevel,
                  SizedBox(height: 15.0),
                  keluhanPernafasan,
                  SizedBox(height: 15.0),
                  consumeAntibiotik,
                  SizedBox(height: 15.0),
                  allergies,
                  SizedBox(height: 15.0),
                  otherComplaint,
                  SizedBox(height: 15.0),
                  checkUpButton,
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
  }
}