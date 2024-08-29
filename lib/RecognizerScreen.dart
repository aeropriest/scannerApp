import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class RecognizerScreen extends StatefulWidget {
  File image;
  RecognizerScreen(this.image);

  @override
  State<RecognizerScreen> createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent, title: Text('Recgonizer')),
        body: Container(
          child: Image.file(this.widget.image),
        ));
  }
}
