import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_ffi_test/flutter_ffi_test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int result;

  @override
  void initState() {
    super.initState();
    FlutterFfiTest.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('native add result: $result\n'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("add"),
          onPressed: () {
            setState(() {
              result = FlutterFfiTest.addNumberByNative(Random().nextInt(100), Random().nextInt(50));
            });
          },
        ),
      ),
    );
  }
}
