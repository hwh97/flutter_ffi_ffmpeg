import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';

typedef navive_add = Int32 Function(Int32 a, Int32 b);
typedef NaviveAdd = int Function(int a, int b);

class FlutterFfiTest {
  static const MethodChannel _channel =
      const MethodChannel('flutter_ffi_test');
  static DynamicLibrary nativelib;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void init() {
    nativelib = Platform.isAndroid
        ? DynamicLibrary.open("libflutter_ffi_test.so")
        /// pod target 关闭 bit code
        /// target.build_configurations.each do |config|
        /// config.build_settings['ENABLE_BITCODE'] = 'NO'
        : DynamicLibrary.process();
        // : DynamicLibrary.open("flutter_ffi_test.framework/flutter_ffi_test");
  }

  static int addNumberByNative(int a, int b) {
    final addPointer = nativelib.lookup<NativeFunction<navive_add>>("addInt");
    NaviveAdd addFunction = addPointer.asFunction<NaviveAdd>();
    final result = addFunction(a, b);
    return result;
  }
}
