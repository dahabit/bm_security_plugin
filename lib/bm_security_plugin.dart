import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'package:flutter/services.dart';

typedef _is_magisk_present_native = ffi.Int32 Function();
typedef _is_magisk_present = int Function();

class BMSecurityPlugin {
  static const MethodChannel _channel =
      const MethodChannel('bm_security_plugin');

  static Future<bool> get deviceIsJailbroken async {
    bool isJailbroken = await _channel.invokeMethod<bool>('deviceIsJailbroken');

    if (Platform.isAndroid) {
      final ffi.DynamicLibrary _lib = ffi.DynamicLibrary.open('libNMD.so');
      final isMagiskPresentNativePointer =
          _lib.lookup<ffi.NativeFunction<_is_magisk_present_native>>(
              'isMagiskPresentNative');
      final isMagiskPresentNative =
          isMagiskPresentNativePointer.asFunction<_is_magisk_present>();

      final magiskAvailable = isMagiskPresentNative() == 1;

      return (isJailbroken || magiskAvailable) ?? true;
    }

    return isJailbroken ?? true;
  }
}
