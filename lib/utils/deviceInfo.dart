import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceInfo {
  static const _platform =
      const MethodChannel('com.globalorder.h_order/deviceInfo');

  static Future<int> batteryLevel() async {
    return await _platform.invokeMethod('getBatteryLevel');
  }

  static Future<String> deviceId() async {
    return await _platform.invokeMethod('getDeviceId');
  }

  static Future<String> serialNumber() async {
    // if (Platform.isAndroid) {
    //   if (!await _checkPermission(Permission.storage)) {
    //     throw 'permission denied';
    //   }

    //   final path = await ExtStorage.getExternalStoragePublicDirectory(
    //       ExtStorage.DIRECTORY_DOCUMENTS);
    //   final file = File('$path/serial_number');

    //   if (!await file.exists()) {
    //     return '';
    //   }

    //   return await file.readAsString();
    // }

    // throw 'non-android device is not supported.';
    final a = await _platform.invokeMethod('getSerialNumber');
    print(a);

    return a;
  }

  static Future<String> scanSerialNumber() async {
    if (!await _checkPermission(Permission.camera)) {
      throw 'permission denied';
    }

    final code = await FlutterBarcodeScanner.scanBarcode(
        '#ffffff', '취소', false, ScanMode.BARCODE);

    return await writeSerialNumber(code);
  }

  static Future<String> writeSerialNumber(String value) async {
    if (!Platform.isAndroid) {
      throw 'non-android device is not supported.';
    }

    if (!await _checkPermission(Permission.storage)) {
      throw 'permission denied';
    }

    final path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS);
    final file = File('$path/serial_number');

    if (await file.exists()) {
      await file.delete();
    }

    final newFile = await file.create(recursive: true);
    await newFile.writeAsString(value);

    return value;
  }

  static Future<bool> _checkPermission(Permission permission) async {
    final condition = await permission.isGranted;

    if (!condition) {
      await permission.request();
      return await permission.isGranted;
    }

    return condition;
  }
}
