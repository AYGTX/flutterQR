import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  String qrData = "";
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (qrData == "")
              Image.network(
                  "https://semantic-ui.com/images/wireframe/image.png")
            else
              Screenshot(
                child: Column(children: <Widget>[
                  QrImage(
                    backgroundColor: Colors.white,
                    data: qrData,
                    foregroundColor: Colors.indigo,
                  ),
                  if (_hidden = true)
                  VxBox(child: Text(qrData, style: TextStyle(fontSize:  25),).centered()).width(MediaQuery.of(context).size.width ).white.make().centered()
                ]),
                controller: screenshotController,
              ),
            TextField(
              controller: qrdataFeed,
              decoration: InputDecoration(
                hintText: "Input your link or data",
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: RaisedButton(
                  color: Colors.indigo,
                  padding: EdgeInsets.all(15.0),
                  onPressed: () async {
                    if (qrdataFeed.text.isEmpty) {
                      //a little validation for the textfield
                      setState(() {
                        qrData = "";
                      });
                      // Showing TOAST when Input field is totally empty
                      VxToast.show(context,
                          msg: "TEXT FIELD IS EMPTY", bgColor: Colors.indigo);
                    } else {
                      setState(() {
                        qrData = qrdataFeed.text;
                      });
                    }
                  },
                  child: Text('GENERATE').text.white.make()),
            ),
            if (qrData!="")
            FloatingActionButton(
              onPressed: () {
                _hidden = true;
                screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((File image) async {
                  print("Capture Done");
                  setState(() {
                    _imageFile = image;
                  });
                  final result = await ImageGallerySaver.saveImage(
                      image.readAsBytesSync());
                  print("File Saved to Gallery");
                  _hidden = false;
                }).catchError((onError) {
                  print(onError);
                });
              },
              tooltip: 'Increment',
              child: Icon(Icons.save_alt),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}
