/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/permission_service.dart
 * Created Date: 2021-08-13 11:38:37
 * Last Modified: 2021-11-19 07:46:08
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:salesworxm/enums/permission_type.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<PermissionStatus> request(AppPermissionType type) async {
    switch (type) {
      case AppPermissionType.camera:
        return await handler.Permission.camera.request();
      case AppPermissionType.location:
        return await handler.Permission.location.request();
      case AppPermissionType.microphones:
        return await handler.Permission.microphone.request();
      case AppPermissionType.notification:
        return await handler.Permission.notification.request();
      case AppPermissionType.photoLibraray:
        return await handler.Permission.photos.request();
      case AppPermissionType.storage:
        return await handler.Permission.storage.request();
    }
  }

  static Future<bool> isGranted(handler.Permission permission) async =>
      await permission.isGranted;
}
