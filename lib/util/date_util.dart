/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesportal/lib/util/date_util.dart
 * Created Date: 2021-11-23 07:56:54
 * Last Modified: 2021-12-07 16:08:04
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:salesworxm/service/navigator_service.dart';
import 'package:salesworxm/view/common/app_dialog.dart';

class DateUtil {
  static String prevMonth() {
    var date = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(DateTime(date.year, date.month - 1, date.day));
  }

  static String now() {
    var date = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String getTimeNow() {
    return '${DateTime.now().hour < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}${DateTime.now().minute < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}${DateTime.now().second < 10 ? '0${DateTime.now().second}' : '${DateTime.now().second}'}';
  }

  static Future<bool> checkDateIsBefore(
      String? startDate, String? endDate) async {
    if (startDate != null && endDate != null) {
      var start = DateTime.parse(startDate);
      var end = DateTime.parse(endDate);
      var equal = start.year == end.year &&
          start.month == end.month &&
          start.day == end.day;
      var isBefore = start.isBefore(end) || equal;
      if (!isBefore) {
        AppDialog.showSignglePopup(
            NavigationService.kolonAppKey.currentContext!,
            '${tr('start_date_before_end_date')}');
        return false;
      }
    }
    return true;
  }
}
