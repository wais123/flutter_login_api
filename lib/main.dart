import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'halaman2.dart';

void main() {
  runApp(MaterialApp(
    home: LatihanApi(),
  ));
}

class LatihanApi extends StatefulWidget {
  @override
  _LatihanApiState createState() => _LatihanApiState();
}

class _LatihanApiState extends State<LatihanApi> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool passwordVisible = false;
  Future<String> _login() async {
    final responseLogin =
        await http.post("http://dms.sinergycode.com/api/auth/login", body: {
      "email": email.text,
      "password": password.text,
    });
    var dataResponse = json.decode(responseLogin.body);
    var data = dataResponse["data"];

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.setString("token", data['token']);

    if(dataResponse["code"] == 0){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Halaman2(
            token: data['token'],
          )));
    }else{
      print("gagal login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: new EdgeInsets.only(left: 20.0),
              child: new Align(
                child: Text(
                  "Email",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            new Padding(padding: new EdgeInsets.only(top: 10.0)),
            SizedBox(
              height: 40.0,
              child: new TextField(
                controller: email,
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
                  hintText: "Email",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
            new Padding(padding: new EdgeInsets.only(top: 30.0)),
            Container(
              padding: new EdgeInsets.only(left: 20.0),
              child: new Align(
                child: Text(
                  "Password",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            new Padding(padding: new EdgeInsets.only(top: 10.0)),
            SizedBox(
              height: 40.0,
              child: new TextField(
                controller: password,
                obscureText: !passwordVisible,
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                  suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      }),
                  hintText: "Password",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
//                      color: Color(0xff01A2F1),
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
//                    borderSide: BorderSide(color: Color(0xff01A2F1), width: 2.0),
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
            new Padding(padding: new EdgeInsets.only(top: 20.0)),
            new MaterialButton(
              minWidth: 250.0,
              height: 40.0,
              onPressed: () {
                _login();
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.grey)
              ),
//                    color: Color(0xff01A2F1),
              child: Text('login',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
