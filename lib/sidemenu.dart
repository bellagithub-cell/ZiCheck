import 'package:flutter/material.dart';
import 'package:zicheckk/history.dart';
import 'package:zicheckk/main.dart';
import 'package:zicheckk/profile.dart';
import 'package:zicheckk/showalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget {

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", null);
    preferences.commit();

  }

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
            onTap: () => {
              signOut(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              ),
            }
          ),
        ],
      ),
    );
  }
}
