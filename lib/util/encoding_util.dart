/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/util/encoding_util.dart
 * Created Date: 2021-08-21 16:38:26
 * Last Modified: 2021-12-27 12:00:18
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:convert';

class EncodingUtils {
  static encodeBase64({
    required String str,
  }) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    return stringToBase64.encode(str);
  }

  static List<int> strToAsc(String str) {
    AsciiCodec ascCodec = new AsciiCodec();
    return ascCodec.encode(str);
  }

  static String ascToStr(List<int> uint8list) {
    AsciiCodec ascCodec = new AsciiCodec();
    return ascCodec.decode(uint8list);
  }

  static List<int> strToUtf8(String str) {
    return utf8.encode(str);
  }

  static String utf8ToStr(List<int> utf8List) {
    return utf8.decode(utf8List);
  }

  static String utf8ToBase64(List<int> utf8List) {
    return base64Encode(utf8List);
  }

  static String ascToBase64(List<int> uint8list) {
    Base64Codec base64codec = new Base64Codec();
    return base64codec.encode(uint8list);
  }

  static List<int> base64ToAsc(String str) {
    Base64Codec base64codec = new Base64Codec();
    return base64codec.decode(str);
  }

  static Future<String> convertKeyAndValueToBase64(
      List<String> strList, List<String> valueList) async {
    if (strList.isEmpty) {
      return '';
    }
    List<int> tempList = [];
    assert(strList.length == valueList.length);

    await Future.delayed(Duration.zero, () {
      for (var i = 0; i < strList.length - 1; i++) {
        tempList.addAll(strToUtf8(strList[i]));
        tempList.addAll(strToUtf8('\b'));
      }
    }).whenComplete(() {
      tempList.addAll(strToUtf8(strList[strList.length - 1]));
      tempList.addAll(strToUtf8('\f'));
      for (var i = 0; i < valueList.length - 1; i++) {
        tempList.addAll(strToUtf8(valueList[i]));
        tempList.addAll(strToUtf8('\b'));
      }
      tempList.addAll(strToUtf8(valueList[valueList.length - 1]));
    });
    var result = utf8ToBase64(tempList);
    return result;
  }

  static Future<String> base64Convert(Map<String, dynamic> mapData) async {
    List<String> keyList = [];
    List<String> valueList = [];

    mapData.forEach((key, value) {
      keyList.add(key);
      valueList.add(value ?? '');
    });
    final result =
        await EncodingUtils.convertKeyAndValueToBase64(keyList, valueList);
    print('base64ConvertFrom Map::  $result');
    return result;
  }

  static Future<String> base64ConvertFromListString(List<String> list) async {
    List<int> tempList = [];
    for (var i = 0; i < list.length; i++) {
      tempList.addAll(strToUtf8(list[i].trim()));
      if (i != list.length - 1) {
        tempList.addAll(strToUtf8('\b'));
      }
    }
    var result = utf8ToBase64(tempList);
    print('base64ConvertFrom List<String> $result');
    return result;
  }

  static Future<String> base64ConvertForListMap(
      List<Map<String, dynamic>> listMapData) async {
    var result = '';
    for (var i = 0; i < listMapData.length; i++) {
      List<String> keyList = [];
      List<String> valueList = [];
      (int index) {
        listMapData[index].forEach((key, value) async {
          keyList.add(key);
          valueList.add(value);
          result = await EncodingUtils.convertKeyAndValueToBase64(
              keyList, valueList);
          if (i != listMapData.length - 1) {
            result = result + utf8ToBase64(strToUtf8('\b'));
          }
        });
      }(i);
    }
    print('base64ConvertFor List<Map<String, dynamic>::$result');
    return result;
  }
}
