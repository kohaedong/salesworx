/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/hive_service.dart
 * Created Date: 2021-08-17 13:17:07
 * Last Modified: 2021-12-22 12:56:57
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:salesworxm/enums/common_code_return_type.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salesworxm/enums/hive_box_type.dart';
import 'package:salesworxm/model/commonCode/t_code_model.dart';
import 'package:salesworxm/model/commonCode/t_values_model.dart';
import 'package:salesworxm/model/commonCode/et_dd07v_customer_category_model.dart';
import 'package:salesworxm/util/hive_select_data_util.dart';

typedef SearchTcodeConditional = bool Function(TCodeModel);
typedef SearchTvalueConditional = bool Function(TValuesModel);
typedef SearchEtDd07vCustomerConditional = bool Function(EtDd07vCustomerModel);

class HiveService {
  factory HiveService() => _sharedInstance();
  static HiveService? _instance;
  HiveService._();
  static HiveService _sharedInstance() {
    if (_instance == null) {
      _instance = HiveService._();
    }
    return _instance!;
  }

  static HiveBoxType? cureenBoxType;
  static init(HiveBoxType boxType) {
    cureenBoxType = boxType;
  }

  static Future<Box> getBox() async {
    switch (cureenBoxType!) {
      case HiveBoxType.T_CODE:
        return await Hive.boxExists(cureenBoxType!.boxName)
            ? Hive.isBoxOpen(cureenBoxType!.boxName)
                ? Hive.box<TCodeModel>(cureenBoxType!.boxName)
                : await Hive.openBox<TCodeModel>(cureenBoxType!.boxName)
            : await Hive.openBox<TCodeModel>(cureenBoxType!.boxName);
      case HiveBoxType.T_VALUE:
        return await Hive.boxExists(cureenBoxType!.boxName)
            ? Hive.isBoxOpen(cureenBoxType!.boxName)
                ? Hive.box<TValuesModel>(cureenBoxType!.boxName)
                : await Hive.openBox<TValuesModel>(cureenBoxType!.boxName)
            : await Hive.openBox<TValuesModel>(cureenBoxType!.boxName);
      case HiveBoxType.T_VALUE_COUNTRY:
        return await Hive.boxExists(cureenBoxType!.boxName)
            ? Hive.isBoxOpen(cureenBoxType!.boxName)
                ? Hive.box<TValuesModel>(cureenBoxType!.boxName)
                : await Hive.openBox<TValuesModel>(cureenBoxType!.boxName)
            : await Hive.openBox<TValuesModel>(cureenBoxType!.boxName);
      case HiveBoxType.ET_CUSTOMER_CATEGORY:
        return await Hive.boxExists(cureenBoxType!.boxName)
            ? Hive.isBoxOpen(cureenBoxType!.boxName)
                ? Hive.box<EtDd07vCustomerModel>(cureenBoxType!.boxName)
                : await Hive.openBox<EtDd07vCustomerModel>(
                    cureenBoxType!.boxName)
            : await Hive.openBox<EtDd07vCustomerModel>(cureenBoxType!.boxName);
      case HiveBoxType.ET_CUSTOMER_CUSTOMS_INFO:
        return await Hive.boxExists(cureenBoxType!.boxName)
            ? Hive.isBoxOpen(cureenBoxType!.boxName)
                ? Hive.box<TValuesModel>(cureenBoxType!.boxName)
                : await Hive.openBox<TValuesModel>(cureenBoxType!.boxName)
            : await Hive.openBox<TValuesModel>(cureenBoxType!.boxName);
    }
  }

//!! 공통코드 다운로드 중 앱 강종 대비 데이터 유효성체크 로직 추가필요.
  static Future<void> save(dynamic data) async {
    switch (cureenBoxType) {
      case HiveBoxType.T_CODE:
        await getBox().then((box) {
          box as Box<TCodeModel>;
          data as List<TCodeModel>;
          box.addAll(data);
        });
        break;
      case HiveBoxType.T_VALUE:
        await getBox().then((box) {
          box as Box<TValuesModel>;
          data as List<TValuesModel>;
          box.addAll(data);
        });
        break;
      case HiveBoxType.T_VALUE_COUNTRY:
        await getBox().then((box) {
          box as Box<TValuesModel>;
          data as List<TValuesModel>;
          box.addAll(data);
        });
        break;
      case HiveBoxType.ET_CUSTOMER_CATEGORY:
        await getBox().then((box) {
          box as Box<EtDd07vCustomerModel>;
          data as List<EtDd07vCustomerModel>;
          box.addAll(data);
        });
        break;
      case HiveBoxType.ET_CUSTOMER_CUSTOMS_INFO:
        await getBox().then((box) {
          box as Box<TValuesModel>;
          data as List<TValuesModel>;
          box.addAll(data);
        });
        break;

      default:
    }
  }

  static Future<List<dynamic>?> getData(
      {SearchTcodeConditional? searchTcodeConditional,
      SearchTvalueConditional? searchTvalueConditional,
      SearchEtDd07vCustomerConditional?
          searchEtDd07vCustomerConditional}) async {
    if (!Hive.isBoxOpen(cureenBoxType!.boxName)) return null;

    if (cureenBoxType == HiveBoxType.T_CODE) {
      return Hive.box<TCodeModel>(cureenBoxType!.boxName)
          .values
          .where((tCode) => searchTcodeConditional!.call(tCode))
          .toList();
    }
    if (cureenBoxType == HiveBoxType.T_VALUE ||
        cureenBoxType == HiveBoxType.T_VALUE_COUNTRY ||
        cureenBoxType == HiveBoxType.ET_CUSTOMER_CUSTOMS_INFO) {
      return Hive.box<TValuesModel>(cureenBoxType!.boxName)
          .values
          .where((tValue) => searchTvalueConditional!.call(tValue))
          .toList();
    }

    if (cureenBoxType == HiveBoxType.ET_CUSTOMER_CATEGORY) {
      return Hive.box<EtDd07vCustomerModel>(cureenBoxType!.boxName)
          .values
          .where((etCustomer) =>
              searchEtDd07vCustomerConditional!.call(etCustomer))
          .toList();
    }
  }

  static Future<void> closeBox() async {
    if (Hive.isBoxOpen(cureenBoxType!.boxName))
      await Hive.box(cureenBoxType!.boxName).close();
  }

  static Future<void> deleteBox() async {
    if (await Hive.boxExists(cureenBoxType!.boxName)) {
      await Hive.deleteBoxFromDisk(cureenBoxType!.boxName);
    }
  }

  static Future<void> clearBox() async {
    if (Hive.isBoxOpen(cureenBoxType!.boxName))
      await Hive.box(cureenBoxType!.boxName).clear();
  }

  static Future<String> getDataFromTCodeByKeyCode(
    String code,
    String cdgrp,
  ) async {
    final result = await HiveSelectDataUtil.select(HiveBoxType.T_CODE,
        tcodeConditional: (tcode) {
          return tcode.cdgrp == '$cdgrp' &&
              tcode.cdnam != null &&
              tcode.cditm == '$code';
        },
        tcodeResultCondition: (tcode) => tcode.cdnam!);
    return result.strList != null && result.strList!.isNotEmpty
        ? result.strList![0]
        : '';
  }

  static Future<String> getSingleDataBySearchKey(
    String codeOrValue,
    String tname, {
    int? searchLevel,
    CommonCodeReturnType? returnType,
    bool? isMatchGroup1KeyList,
    bool? isMatchGroup2KeyList,
    bool? isMatchGroup3KeyList,
    bool? isMatchGroup4KeyList,
    String? group0SearchKey,
    String? group1SearchKey,
    String? group2SearchKey,
    String? group3SearchKey,
    String? group4SearchKey,
  }) async {
    final result = await HiveSelectDataUtil.select(
      HiveBoxType.T_VALUE,
      returnType: returnType,
      searchLevel: searchLevel ?? 0,
      group0SearchKey: group0SearchKey,
      group1SearchKey: group1SearchKey,
      group2SearchKey: group2SearchKey,
      group3SearchKey: group3SearchKey,
      group4SearchKey: group4SearchKey,
      isMatchGroup1KeyList: isMatchGroup1KeyList,
      isMatchGroup2KeyList: isMatchGroup2KeyList,
      isMatchGroup3KeyList: isMatchGroup3KeyList,
      isMatchGroup4KeyList: isMatchGroup4KeyList,
      tvalueConditional: (tValue) {
        return tValue.tname == '$tname' &&
            tValue.helpValues!.contains('$codeOrValue');
      },
    );
    return result.strList![0];
  }

  static Future<List<String>?> getDataFromTValue(
      {String? group0SearchKey,
      String? group1SearchKey,
      String? group2SearchKey,
      String? group3SearchKey,
      String? group4SearchKey,
      int? searchLevel,
      String? tname}) async {
    final resultList = await HiveSelectDataUtil.select(
      HiveBoxType.T_VALUE,
      tvalueConditional: (tValue) {
        return tValue.tname == '$tname' && tValue.helpValues!.isNotEmpty;
      },
      searchLevel: searchLevel,
      group0SearchKey: group0SearchKey,
      group1SearchKey: group1SearchKey,
      group2SearchKey: group2SearchKey,
      group3SearchKey: group3SearchKey,
      group4SearchKey: group4SearchKey,
    );

    return resultList.strList;
  }

  static Future<bool> isNeedDownLoad() async {
    await HiveService.init(HiveBoxType.T_CODE);
    await HiveService.getBox();
    var dateTime = await HiveService.getBox().then((box) {
      if (box.isNotEmpty) {
        var temp = box.values.first as TCodeModel;
        return temp.timestamp;
      } else {
        return null;
      }
    });
    return dateTime == null || DateTime.now().difference(dateTime).inDays > 1
        ? true
        : false;
  }

  static Future<List<String>?> getDataFromTCode(String cdgrp,
      {String? cditm, String? cdnam, bool? isMatchCditm}) async {
    final resultList = await HiveSelectDataUtil.select(HiveBoxType.T_CODE,
        tcodeConditional: (tcode) {
          if (cdnam != null) {
            return tcode.cdgrp == cdgrp && tcode.cdnam == cdnam;
          }
          if (cditm != null) {
            return tcode.cdgrp == cdgrp && tcode.cditm == cditm;
          }
          return tcode.cdgrp == cdgrp && tcode.cditm != '';
        },
        tcodeResultCondition: (tcode) =>
            isMatchCditm != null ? tcode.cditm! : tcode.cdnam!);
    return resultList.strList;
  }
}
