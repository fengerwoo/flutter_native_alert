import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_alert/flutter_native_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Native Alert'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton.icon(
                  onPressed: () async {
                    bool ret = await FlutterNativeAlert.getInstance().showConfirm(
                      title: "Welcome to use",
                      message: "flutter_native_alert offers the ability to display Android and iOS native dialog and toast",
                      confirmButtonText: "OK",  // Optional, the text of the confirmation button, null means that the button is not displayed
                      cancelButtonText: "Cancel", // Optional, the text of the cancel button, null means that the button is not displayed
                    );

                    FlutterNativeAlert.getInstance().showToast("You clicked：" + (ret ? "OK":"Cancel"));
                  },
                  icon: Icon(Icons.privacy_tip_rounded),
                  label: Text("showConfirm")
              ),


              ElevatedButton.icon(
                  onPressed: (){
                    FlutterNativeAlert.getInstance().hideConfirm();
                  },
                  icon: Icon(Icons.privacy_tip_outlined),
                  label: Text("hideConfirm")
              ),

              ElevatedButton.icon(
                  onPressed: (){
                    FlutterNativeAlert.getInstance().showToast("I'm a Toast", duration: Duration(milliseconds: 1500));
                  },
                  icon: Icon(Icons.info),
                  label: Text("showToast")
              ),

            ],
          ),
        ),
      ),
    );
  }
}
