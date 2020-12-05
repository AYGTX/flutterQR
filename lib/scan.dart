import 'package:barcode_scan/barcode_scan.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Result").text.indigo900.bold.center.italic.size(25).make(),
            Text(qrCodeResult).text.center.size(20).make(),
            SizedBox(height: 20.0,),
           FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                ScanResult codeSanner = await BarcodeScanner.scan();
                setState(() {
                  qrCodeResult = codeSanner as String;
                });
              },
              child: Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
