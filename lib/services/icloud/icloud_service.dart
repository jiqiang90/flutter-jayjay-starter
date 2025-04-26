import 'dart:io';
import 'package:flutter/services.dart';

class ICloudService {
  static const _platform = MethodChannel('com.jayjay.starter/icloud');

  Future<bool> isICloudAvailable() async {
    try {
      final bool result = await _platform.invokeMethod('isICloudAvailable');
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<bool> syncToICloud(String filePath) async {
    try {
      final Map<String, dynamic> args = {
        'filePath': filePath,
      };
      final bool result = await _platform.invokeMethod('syncToICloud', args);
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<bool> restoreFromICloud(String destinationPath) async {
    try {
      final Map<String, dynamic> args = {
        'destinationPath': destinationPath,
      };
      final bool result = await _platform.invokeMethod('restoreFromICloud', args);
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }
} 