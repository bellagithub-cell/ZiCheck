import 'package:flutter/material.dart';
import 'package:zicheckk/history.dart';
import 'package:zicheckk/profile.dart';
import 'package:zicheckk/showalert.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Zi Check',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Check Up'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Riwayat Checkup'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Darurat'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowAlert()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
