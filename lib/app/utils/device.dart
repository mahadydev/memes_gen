import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceUtil {
  static Future<bool> getPermission() async {
    bool androidExistNotSave = false;
    bool isGranted;
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;

      if (androidExistNotSave) {
        isGranted = await (sdkInt > 33 ? Permission.photos : Permission.storage)
            .request()
            .isGranted;
      } else {
        isGranted =
            sdkInt < 29 ? await Permission.storage.request().isGranted : true;
      }
    } else {
      isGranted = await Permission.photosAddOnly.request().isGranted;
    }

    return isGranted;
  }
}
