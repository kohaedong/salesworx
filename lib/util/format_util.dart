/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/util/number_format.dart
 * Created Date: 2021-09-08 09:34:02
 * Last Modified: 2021-11-16 17:04:30
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

class FormatUtil {
  static String addComma(String number) {
    number = number.trim();
    if (double.tryParse(number) != null) {
      if (double.parse(number) == 0) {
        return '';
      } else {
        NumberFormat formater = NumberFormat();
        if (double.parse(number) > 999) formater = NumberFormat('#,000');
        return formater.format(double.tryParse(number));
      }
    } else {
      return number;
    }
  }

  static String formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }

  static String formatZero(String str) {
    return int.tryParse(str) != null ? int.tryParse(str).toString() : str;
  }

  static String moneyWithCurrencyUnit(String number, String unit) {
    number = number.trim();
    if (double.tryParse(number) != null) {
      var temp = double.tryParse(number);
      if (temp == 0) {
        return '0$unit';
      } else {
        number = '${addComma(number)} $unit';
        return number;
      }
    } else {
      return number;
    }
  }

  static String addCommaAndUsdForDecimals(String str, String unit) {
    if (double.tryParse(str) != null) {
      var temp = double.parse(str);
      if (temp == 0) {
        return '';
      } else {
        str = '${formatNum(temp, 2)} $unit';
        return str;
      }
    } else {
      return str;
    }
  }

  static String moneyAndUnitDouble(
      String money, String moneyUnit, String queantity, String queantityUnit) {
    if (double.tryParse(money) != null) {
      var temp = double.parse(money);
      if (temp == 0) {
        return '';
      } else {
        money = '${formatNum(temp, 2)} $moneyUnit';
        queantity = '${int.parse(queantity)}$queantityUnit';
        return '$money / $queantity';
      }
    } else {
      return '$money$moneyUnit$queantity$queantityUnit';
    }
  }

  static String addPercent(String str) {
    if (double.tryParse(str) != null) {
      var temp = double.parse(str);
      return '${formatNum(temp, 1)}%';
    } else {
      return str;
    }
  }

  static String addBrackets(String str) {
    return '($str)';
  }

  static String addPeriod(String? str1, String? str2) {
    if (str1 != null && str1 != '' && str2 != null && str2 != '') {
      var temp1 = addDashForDateStr(str1);
      var temp2 = addDashForDateStr(str2);
      return '$temp1 ~ $temp2';
    } else {
      return '';
    }
  }

  static double randomSimmerSize(int max, int min) {
    Random random = new Random();

    return (random.nextInt(max - min) + min).toDouble();
  }

  static String addDashForMonth(String str) {
    if (str.length == 8) {
      return str.substring(4).replaceRange(2, 2, '-');
    } else
      return str;
  }

  static String addDashForPhoneNumber(String str) {
    if (str.length == 11) {
      return str.replaceRange(3, 3, '-').replaceRange(8, 8, '-');
    } else
      return str;
  }

  static String addDashForLicenceNumber(String str) {
    if (str.length == 10) {
      return str.replaceRange(3, 3, '-').replaceRange(6, 6, '-');
    } else
      return str;
  }

  static String addDashForDateStr(String str) {
    if (str.trim().length == 8) {
      return str.trim().replaceRange(4, 4, '-').replaceRange(7, 7, '-');
    } else
      return str;
  }

  static String addDashForDoubleDateStr(String str, String str2) {
    if (str.trim().length == 8 && str2.trim().length == 8) {
      return '${str.trim().replaceRange(4, 4, '-').replaceRange(7, 7, '-')} ~ ${str2.trim().replaceRange(4, 4, '-').replaceRange(7, 7, '-')}';
    } else
      return '$str ~ $str2';
  }

  static String addDashForDateStr2(String str) {
    if (str.length == 8) {
      return str.substring(2).replaceRange(2, 2, '-').replaceRange(5, 5, '-');
    } else
      return str;
  }

  static String subToStartSpace(String str) {
    if (str.startsWith(' ')) {
      str = str.substring(1);
    }

    return str.substring(0, str.indexOf(' '));
  }

  static String subToEndSpace(String str) {
    if (str.startsWith(' ')) {
      str = str.substring(1);
    }
    return str.substring(str.indexOf(' ') + 1);
  }

  static String currencyUnitConversion(String str) {
    final doubleData = double.tryParse(str);
    if (doubleData != null && doubleData != 0) {
      final unit = 1000000;
      final transData = doubleData / unit;
      return '${transData.truncate()}${tr('million')}';
    }
    return '';
  }

  static String removeDash(String str) {
    return str.replaceAll('-', '');
  }

  static String profitConversion(String saler) {
    if (saler == '0' || saler == '') {
      return '';
    } else {
      return '$saler%';
    }
  }
}
