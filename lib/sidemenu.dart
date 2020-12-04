import 'package:flutter/material.dart';
import 'package:zicheckk/history.dart';
import 'package:zicheckk/main.dart';
import 'package:zicheckk/profile.dart';
import 'package:zicheckk/showalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'check.dart';

class NavDrawer extends StatelessWidget {
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", null);
    preferences.setString("namad", null);
    preferences.setString("namab", null);
    preferences.setString("email", null);
    preferences.setString("id", null);
    preferences.setString("iddok", null);
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
            leading: Icon(Icons.medical_services_outlined),
            title: Text('Check Up'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Check()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.refresh_outlined),
            title: Text('Checkup History'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => History()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_outlined),
            title: Text('Profile'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('Emergency'),
            onTap: () => {
              Navigator.pushReplacement(
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false
                    ),
                  }),
        ],
      ),
    );
  }
}
