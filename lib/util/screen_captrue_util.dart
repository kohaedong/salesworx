/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/commonlogin/lib/util/screen_captrue_util.dart
 * Created Date: 2021-12-13 17:14:35
 * Last Modified: 2022-01-14 15:07:38
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:salesworxm/enums/request_type.dart';
import 'package:salesworxm/service/api_service.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/service/navigator_service.dart';
import 'package:salesworxm/view/common/app_dialog.dart';
import 'package:salesworxm/view/signin/provider/signin_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

typedef ScreenCaptrueCallback = Future<Uint8List?> Function();

class ScreenCaptrueUtil {
  static Future<void> sendImageToServer() async {
    final bytes = await getBitmapFromContext();
    print(bytes);
    final base64Image = base64Encode(bytes ?? []);
    var user = await CacheService.getUser();
    var api = ApiService();
    Map<String, dynamic> body = {
      "methodName": RequestType.SEND_IMAGE_TO_SERVER.serverMethod,
      "methodParam": {
        "appGrpId": Platform.isIOS ? '1555' : '1554',
        "screenId": "${user!.userAccount!}${DateTime.now().toIso8601String()}",
        "screenShot": "$base64Image"
      }
    };
    api.init(RequestType.SEND_IMAGE_TO_SERVER);
    final result = await api.request(body: body);
    if (result!.statusCode == 200) {
      print('send success');
    }
  }

  static Future<Uint8List?> getBitmapFromContext({double? pixelRatio}) async {
    Uint8List? unit8List;
    ui.Image? image;
    return await Future.delayed(Duration.zero, () async {
      var renderObject = NavigationService.screenKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      image = await renderObject.toImage();
      var byte = await image!.toByteData(format: ui.ImageByteFormat.png);
      unit8List = byte!.buffer.asUint8List();
    }).then((_) {
      // Navigator.pushNamed(
      //     NavigationService.kolonAppKey.currentContext!, TestPage.routeName,
      //     arguments: unit8List);
      return unit8List;
    });
  }

//dd
  static void screenListen() async {
    if (Platform.isIOS) {
      var lock = false;
      CacheService.setIsDisableUpdate(true);
      EventChannel iosEvent = EventChannel('kolonbase/keychain/event');
      iosEvent.receiveBroadcastStream("screen").listen((result) async {
        if (result != null) {
          if (!lock) {
            lock = true;
            Future.delayed(Duration(seconds: 1), () async {
              final dialogResult = await AppDialog.showDangermessage(
                  NavigationService.kolonAppKey.currentContext!,
                  '${tr('scrren_info')}');
              if (dialogResult != null) {
                Future.delayed(Duration(seconds: 2), () {
                  sendImageToServer().then((value) {
                    SigninProvider().setIsWaterMarkeUser();
                    lock = false;
                  });
                });
              }
            });
          }
        }
      }, onError: (e) {
        print(e);
      });
    }
  }
}
