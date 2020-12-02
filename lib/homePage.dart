import 'dart:async';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zicheckk/home.dart';
import 'chart.dart';
import 'global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final int bodyTemp;
  final int sysBloodPress;
  final int diasBloodPress;
  final int valStressLevel;
  final String breathComplaint;
  final String consumeAntibiotic;
  final String allergies;
  final String otherComplaint;

  HomePage(
      this.bodyTemp,
      this.sysBloodPress,
      this.diasBloodPress,
      this.valStressLevel,
      this.breathComplaint,
      this.consumeAntibiotic,
      this.allergies,
      this.otherComplaint);

  @override
  HomePageView createState() {
    return HomePageView(
        this.bodyTemp,
        this.sysBloodPress,
        this.diasBloodPress,
        this.valStressLevel,
        this.breathComplaint,
        this.consumeAntibiotic,
        this.allergies,
        this.otherComplaint);
  }
}

class HomePageView extends State<HomePage> {
  int bodyTemp;
  int sysBloodPress;
  int diasBloodPress;
  int valStressLevel;
  String breathComplaint;
  String consumeAntibiotic;
  String allergies;
  String otherComplaint;

  HomePageView(
      this.bodyTemp,
      this.sysBloodPress,
      this.diasBloodPress,
      this.valStressLevel,
      this.breathComplaint,
      this.consumeAntibiotic,
      this.allergies,
      this.otherComplaint);

  bool _toggled = false;
  bool _processing = false;
  List<SensorValue> _data = [];
  CameraController _controller;
  double _alpha = 0.3;
  int _bpm = 0;
  List<int> heartRate = [];

  regisCheckUp(int heartRate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String id;
    id = preferences.getString("id");
    debugPrint("masuk Pak jamal");
    debugPrint("cek " + bodyTemp.toString());
    debugPrint("cek " + sysBloodPress.toString());
    debugPrint("cek " + diasBloodPress.toString());
    debugPrint("cek " + heartRate.toString());
    debugPrint("cek " + valStressLevel.toString());
    debugPrint("cek " + breathComplaint);
    debugPrint("cek " + consumeAntibiotic);
    debugPrint("cek " + allergies);
    debugPrint("cek " + otherComplaint);
    debugPrint("cek " + id);

    final response =
        await http.post(global.ipServer + "/flutter/regischeckup.php", body: {
      "body_temp": bodyTemp.toString(),
      "blood_press_sis": sysBloodPress.toString(),
      "blood_press_dias": diasBloodPress.toString(),
      "heart_rate": heartRate.toString(),
      "stress_level": valStressLevel.toString(),
      "breath_complaint": breathComplaint,
      "consume_antibiotik": consumeAntibiotic,
      "allergies": allergies,
      "other_complaint": otherComplaint,
      "id_user": id,
    }).then((response) => response);

    /*final response = await http
        .post(global.ipServer+"/flutter/regischeckup.php", //ganti sesuai komputer masing2
        body: {
          "body_temp": bodyTemp
        }).then((response) => response);*/
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      debugPrint("masuk ke database");
      debugPrint(pesan);
    }
  }

  _toggle() {
    _initController().then((onValue) {
      Wakelock.enable();
      setState(() {
        _toggled = true;
        _processing = false;
      });
      _updateBPM();
    });
  }

  _untoggle() {
    _disposeController();
    Wakelock.disable();
    setState(() {
      _toggled = false;
      _processing = false;
    });
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller.initialize();
      Future.delayed(Duration(milliseconds: 500)).then((onValue) {
        _controller.setFlashMode(FlashMode.torch);
      });
      _controller.startImageStream((CameraImage image) {
        if (!_processing) {
          setState(() {
            _processing = true;
          });
          _scanImage(image);
        }
      });
    } catch (Exception) {
      print(Exception);
    }
  }

  _updateBPM() async {
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {
      _values = List.from(_data);
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm +=
                60000 / (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        setState(() {
          _bpm = (1 - _alpha) * _bpm + _alpha * _bpm;
          this._bpm = ((1 - _alpha) * _bpm + _alpha * _bpm).toInt();
          heartRate.add(_bpm.toInt());
          if (heartRate.length == 15) {
            _untoggle();
            debugPrint(heartRate.toString());
            int tampilin = 0;
            for (int i = 0; i < 15; i++) {
              tampilin = tampilin + heartRate[i];
            }
            tampilin = tampilin ~/ 15;
            Widget cekButton = FlatButton(
                onPressed: () {
                  regisCheckUp(tampilin);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false);
                },
                child: Icon(Icons.check));

            Widget cancelButton = FlatButton(
              onPressed: () {
                Navigator.pop(context);
                heartRate.clear();
              },
              child: Text("Ulang Kembali"),
            );

            //bikin alert
            AlertDialog alert = AlertDialog(
              title: Text("Heart Rate"),
              content: Text(
                "Heart Rate " + tampilin.toString(),
                textAlign: TextAlign.justify,
              ),
              actions: [cancelButton, cekButton],
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
        });
      }
      await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
    }
  }

  _scanImage(CameraImage image) {
    double _avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (_data.length >= 50) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(DateTime.now(), _avg));
    });
    Future.delayed(Duration(milliseconds: 1000 ~/ 30)).then((onValue) {
      setState(() {
        _processing = false;
      });
    });
  }

  _disposeController() {
    _controller.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: _controller == null
                          ? Container()
                          : CameraPreview(_controller),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        (_bpm > 30 && _bpm < 150
                            ? _bpm.round().toString()
                            : "--"),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                  icon: Icon(_toggled ? Icons.favorite : Icons.favorite_border),
                  color: Colors.red,
                  iconSize: 128,
                  onPressed: () {
                    if (_toggled) {
                      _untoggle();
                    } else {
                      _toggle();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: Colors.black),
                child: Chart(_data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
