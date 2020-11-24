import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget cekButton = FlatButton(
        onPressed: () {
          launch("tel://21213123123");
        },
        child: Icon(Icons.check));
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian"),
      content: Text(
        "Dengan menekan tombol 'Darurat', maka Anda akan melakukan panggilan darurat ke rumah sakit terdekat. Saat ini rumah sakit sedang mengalami keramaian. Lakukan panggilan ini apabila benar-benar darurat. Apakah Anda yakin?",
        textAlign: TextAlign.justify,
      ),
      actions: [
        cekButton,
      ],
    );
    return alert;
  }
}
