/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/enums/request_type.dart
 * Created Date: 2021-08-27 10:22:15
 * Last Modified: 2022-01-14 17:07:05
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:io';
import 'package:salesworxm/model/buildConfig/kolon_build_config.dart';
import 'package:salesworxm/service/deviceInfo_service.dart';

enum RequestType {
  RFC_COMMON_CODE,
  CHECK_NOTICE,
  CHECK_UPDATE,
  SIGNIN,
  REQEUST_TOKEN,
  REFRESHE_TOKEN,
  SAVE_ENV,
  GET_ENV,
  SAVE_DEVICE_INFO,
  SEND_SUGGETION,
  REQUEST_ES_LOGIN,
  NOTICE_ALARM,
  NOTICE_ALARM_COUNT,
  NOTICE_ALARM_CONFIRM,
  NOTICE_DONT_SHOW_AGAIN,
  UN_CONFIRM_ALARM,
  SEND_IMAGE_TO_SERVER
}

extension RequestTypeExtension on RequestType {
  bool get isDev => KolonBuildConfig.KOLON_APP_BUILD_TYPE == 'dev';
  String get baseURL => KolonBuildConfig.KOLON_APP_BASE_URL;
  String get prodSalesURL => 'https://apps2.kolon.com';
  String get v2URL => '$baseURL/common/v2/api';
  String get signURL => '$baseURL/common/v2/api/basiclogin/auth';
  String get rfcURL =>
      isDev ? '$baseURL/sales-group/rfc' : '$prodSalesURL/sales-group/rfc';
  String get salesportal => isDev
      ? '$baseURL/sales-group/salesportal'
      : '$prodSalesURL/sales-group/salesportal';
  Future<Map<String, String>> get anotherHeader async {
    final deviceInfo = await DeviceInfoService.getDeviceInfo();
    final Map<String, String> tempHeader = {
      "devicePlatformNm": Platform.isIOS ? "iOS Phone" : "Android Phone",
      "hckMngYn": "n",
      "osVerNm": '${deviceInfo.deviceVersion}'
    };
    switch (this) {
      case RequestType.REQEUST_TOKEN:
        return tempHeader;
      case RequestType.SIGNIN:
        return tempHeader;
      case RequestType.SAVE_ENV:
        return tempHeader;
      case RequestType.GET_ENV:
        return tempHeader;
      case RequestType.SAVE_DEVICE_INFO:
        return tempHeader;
      case RequestType.SEND_SUGGETION:
        return tempHeader;
      case RequestType.NOTICE_DONT_SHOW_AGAIN:
        return tempHeader;
      default:
        return {'Timestamp': DateTime.now().toIso8601String()};
    }
  }

  String url({String? params}) {
    switch (this) {
      case RequestType.REQEUST_TOKEN:
        return '$baseURL/common/oauth/token';
      case RequestType.REFRESHE_TOKEN:
        return '$baseURL/common//oauth/token';
      case RequestType.SIGNIN:
        return '$signURL';
      case RequestType.CHECK_NOTICE:
        return '$v2URL/rest';
      case RequestType.NOTICE_DONT_SHOW_AGAIN:
        return '$v2URL/rest';
      case RequestType.SEND_IMAGE_TO_SERVER:
        return '$v2URL/rest';
      case RequestType.CHECK_UPDATE:
        return '$v2URL/rest';
      case RequestType.SAVE_ENV:
        return '$v2URL/rest';
      case RequestType.GET_ENV:
        return '$v2URL/rest';
      case RequestType.SAVE_DEVICE_INFO:
        return '$v2URL/rest';
      case RequestType.SEND_SUGGETION:
        return '$v2URL/rest';
      case RequestType.RFC_COMMON_CODE:
        return '$salesportal/commoncode';

      case RequestType.REQUEST_ES_LOGIN:
        return '$rfcURL/login';
      case RequestType.NOTICE_ALARM:
        return '$salesportal/alarmlist';
      case RequestType.NOTICE_ALARM_COUNT:
        return '$rfcURL/common';
      case RequestType.NOTICE_ALARM_CONFIRM:
        return '$rfcURL/common';

      case RequestType.UN_CONFIRM_ALARM:
        return '$rfcURL/common';
    }
  }

  String get httpMethod {
    switch (this) {
      default:
        return 'POST';
    }
  }

  String get resultTable {
    switch (this) {
      case RequestType.REQUEST_ES_LOGIN:
        return 'ES_RETURN,ES_LOGIN,T_CODE';
      case RequestType.NOTICE_ALARM:
        return 'ES_RETURN,T_ALARM';
      case RequestType.NOTICE_ALARM_CONFIRM:
        return 'ES_RETURN';
      case RequestType.NOTICE_ALARM_COUNT:
        return 'ES_RETURN,ET_BASESUMMARY';
      case RequestType.NOTICE_DONT_SHOW_AGAIN:
        return '';
      case RequestType.RFC_COMMON_CODE:
        return 'H_TVKO,H_TVKOV,H_TVTA,H_TVKBZ,H_TVBVK,H_T171,H_TVSB,H_TINC,SH_LORD_ZTERM,H_TVKT,ZLTS_H_LTS_AKONT,H_TSKD,SH_DWERK_EXTS,H_TVAG';

      case RequestType.UN_CONFIRM_ALARM:
        return 'ES_RETURN,T_ALARM';
      default:
        return '';
    }
  }

  String get serverMethod {
    switch (this) {
      case RequestType.CHECK_NOTICE:
        return "noticeAll";
      case RequestType.SEND_IMAGE_TO_SERVER:
        return 'screenCapture';
      case RequestType.NOTICE_DONT_SHOW_AGAIN:
        return "saveNoticeTodayHide";
      case RequestType.CHECK_UPDATE:
        return "updateCheck";
      case RequestType.SAVE_ENV:
        return 'saveOfAppUserEnv';
      case RequestType.GET_ENV:
        return 'getOfAppUserEnv';
      case RequestType.SAVE_DEVICE_INFO:
        return 'saveDeviceInfoByAnonymous';
      case RequestType.SEND_SUGGETION:
        return 'saveOfAppOpinionByAnonymous';
      case RequestType.REQUEST_ES_LOGIN:
        return 'Z_LTS_IFS0001';
      case RequestType.NOTICE_ALARM:
        return 'Z_LTS_IFR0074,Z_LTS_IFR0068';
      case RequestType.NOTICE_ALARM_COUNT:
        return 'Z_LTS_IFS0070';
      case RequestType.NOTICE_ALARM_CONFIRM:
        return 'Z_LTS_IFR0068';
      case RequestType.RFC_COMMON_CODE:
        return 'Z_LTS_IFS0002';

      case RequestType.UN_CONFIRM_ALARM:
        //! api 개발 완료 후 추가.
        return '0000000';

      default:
        throw NullThrownError();
    }
  }

  String get tag {
    switch (this) {
      default:
        return "tag_${this.runtimeType}";
    }
  }

  bool get isWithAccessToken {
    switch (this) {
      case RequestType.REQEUST_TOKEN:
        return false;
      case RequestType.REFRESHE_TOKEN:
        return false;
      default:
        return true;
    }
  }
}
