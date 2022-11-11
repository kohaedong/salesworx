/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/deviceInfo_service.dart
 * Created Date: 2021-08-16 21:01:02
 * Last Modified: 2021-11-19 07:46:08
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:salesworxm/model/user/user_device_info.dart';

class DeviceInfoService {
  factory DeviceInfoService() => _sharedInstance();
  static DeviceInfoService? _instance;
  DeviceInfoService._();
  static DeviceInfoService _sharedInstance() {
    if (_instance == null) {
      _instance = DeviceInfoService._();
    }
    return _instance!;
  }

  static Future<UserDeviceInfo> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosDeviceInfo;
    UserDeviceInfo? userDeviceInfo;
    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
      userDeviceInfo = UserDeviceInfo(
          '${iosDeviceInfo.identifierForVendor}',
          'apple',
          '${iosDeviceInfo.utsname.nodename}',
          '${iosDeviceInfo.utsname.machine}',
          '${iosDeviceInfo.systemVersion}');
    }
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      userDeviceInfo = UserDeviceInfo(
          '${androidInfo.androidId}',
          '${androidInfo.brand}',
          '${androidInfo.device}',
          '${androidInfo.model}',
          '${androidInfo.version.sdkInt}');
    }

    return userDeviceInfo!;
  }
}
