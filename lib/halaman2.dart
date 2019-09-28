import 'package:flutter/material.dart';

class Halaman2 extends StatefulWidget {
  final String token;
  Halaman2({this.token});
  @override
  _Halaman2State createState() => _Halaman2State();
}

class _Halaman2State extends State<Halaman2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman2"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("anda telah login"),
            Text("${widget.token}"),
          ],
        ),
      ),
    );
  }
}
