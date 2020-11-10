import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                  ),
                ),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 30),
                        text: "Jhon Doe"))
              ],
            )),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Nomor Telephon : " + "00000"),
            contentPadding: EdgeInsets.fromLTRB(25, 10, 0, 5),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text("Tempat, Tanggal Lahir : " + "Semarang, 31 Junli 1992"),
            contentPadding: EdgeInsets.fromLTRB(25, 5, 0, 5),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Jenis Kelamin: " + "Laki - Laki"),
            contentPadding: EdgeInsets.fromLTRB(25, 5, 0, 5),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Alamat : " + "Jl. Scientia garden no 12"),
            contentPadding: EdgeInsets.fromLTRB(25, 5, 0, 5),
          ),
        ],
      ),
    );
    // throw UnimplementedError();
  }
}
