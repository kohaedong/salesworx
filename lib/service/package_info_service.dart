/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/package_info_service.dart
 * Created Date: 2021-08-17 00:11:38
 * Last Modified: 2021-10-16 12:09:20
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  factory PackageInfoService() => _sharedInstance();
  static PackageInfoService? _instance;
  PackageInfoService._();
  static PackageInfoService _sharedInstance() {
    if (_instance == null) {
      _instance = PackageInfoService._();
    }
    return _instance!;
  }

  static Future<PackageInfo> getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
