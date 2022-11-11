// ignore_for_file: constant_identifier_names

/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/enums/hive_box_type.dart
 * Created Date: 2021-09-09 13:28:48
 * Last Modified: 2021-11-19 07:54:29
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

enum HiveBoxType {
  T_CODE,
  T_VALUE,
  T_VALUE_COUNTRY,
  ET_CUSTOMER_CATEGORY,
  ET_CUSTOMER_CUSTOMS_INFO
}

extension HiveBoxTypeExtension on HiveBoxType {
  String get boxName {
    switch (this) {
      case HiveBoxType.T_CODE:
        return 't_code';
      case HiveBoxType.T_VALUE:
        return 't_value';
      case HiveBoxType.T_VALUE_COUNTRY:
        return 'one_time';
      case HiveBoxType.ET_CUSTOMER_CATEGORY:
        return 'et_customer_category';
      case HiveBoxType.ET_CUSTOMER_CUSTOMS_INFO:
        return 'et_customer_customs_info';
    }
  }
}
