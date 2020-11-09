import 'package:flutter/material.dart';
import 'history.dart';
import 'editprofile.dart';
import 'showalert.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen =
        mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu on Top"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
          // ),
        ],
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: widthScreen / heightScreen,
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Center(
                child: Icon(
                  Icons.medical_services_outlined,
                  size: 100.0,
                ),
                // ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              },
              child: Center(
                child: Icon(
                  Icons.refresh_outlined,
                  size: 100.0,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
              child: Center(
                child: Icon(
                  Icons.supervised_user_circle_outlined,
                  size: 100.0,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowAlert()),
                );
              },
              child: Center(
                child: Icon(
                  Icons.add_alert,
                  size: 100.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
    // throw UnimplementedError();
  }
}
