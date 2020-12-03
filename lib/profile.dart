import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:zicheckk/edit_profile.dart';
import 'package:zicheckk/home.dart';
import 'sidemenu.dart';
import 'detail_history.dart';
import 'global.dart' as global;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // buat ambil id dari share preference
  List data;
  String id;
  var value;
  String namad;
  String namab;
  String nohp;
  String jeniskelamin;
  String alamatrmh;
  String email;
  String tgllahir;

  // dapetin id user
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      // value = preferences.getInt("value");
      // id = value;
      debugPrint(id);
      user();
    });
  }

  // ambil data user sesuai id
  user() async {
    final response = await http.post(
        global.ipServer + "/flutter/user.php", //ganti sesuai komputer masing2
        body: {
          "id": id,
        }).then((response) => response);
    final data = jsonDecode(response.body);
    debugPrint('debug : response : ' + response.body);
    int value = data['value'];
    String pesan = data['message'];
    this.namad = data['hasil']['nama_depan'];
    this.namab = data['hasil']['nama_blkg'];
    this.nohp = data['hasil']['no_hp'];
    if (data['hasil']['jenis_kelamin'] == "P") {
      this.jeniskelamin = "Perempuan";
    } else {
      this.jeniskelamin = "Laki-Laki";
    }
    this.alamatrmh = data['hasil']['alamat_rmh'];
    this.email = data['hasil']['email'];
    this.tgllahir = data['hasil']['tgl_lahir'];
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      getPref();
    });
  }

  // background cover image
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        color: Color(0xFF6CD4FF),
        // image: DecorationImage(
        //     image: AssetImage('assets/images/coverimage.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: new ColorFilter.mode(
        //         Colors.white.withOpacity(0.6), BlendMode.dstATop)),
      ),
    );
  }

  // profile image
  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/avatar.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  // buat loading UI yg muter2
  Future<bool> fetchData() => Future.delayed(Duration(seconds: 5), () {
        debugPrint('Step 1, fetch data');
        return true;
      });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // buat edit button
    final editButton = Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 7, 8),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
              tooltip: 'Toggle',
              child: Icon(Icons.create)),
        ));

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    _buildCoverImage(screenSize),
                    SafeArea(
                        child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: screenSize.height / 6.4),
                          _buildProfileImage(),
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontSize: 30),
                                  text: namad + " " + namab)),
                          Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.teal[900],
                                ),
                                title: Text(
                                  nohp,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat', fontSize: 20.0),
                                ),
                              )),
                          Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.cake,
                                  color: Colors.teal[900],
                                ),
                                title: Text(
                                  tgllahir,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat', fontSize: 20.0),
                                ),
                              )),
                          Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.email,
                                  color: Colors.teal[900],
                                ),
                                title: Text(
                                  email,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat', fontSize: 20.0),
                                ),
                              )),
                          Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.location_on,
                                  color: Colors.teal[900],
                                ),
                                title: Text(
                                  alamatrmh,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat', fontSize: 20.0),
                                ),
                              )),
                          Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.skip_next,
                                  color: Colors.teal[900],
                                ),
                                title: Text(
                                  jeniskelamin,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat', fontSize: 20.0),
                                ),
                              )),
                        ],
                      ),
                    )),
                    editButton,
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    // throw UnimplementedError();
  }
}
