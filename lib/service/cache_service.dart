/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/cache_service.dart
 * Created Date: 2021-08-22 19:45:10
 * Last Modified: 2022-01-14 15:02:54
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:convert';
import 'package:salesworxm/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesworxm/model/commonCode/is_login_model.dart';

class CacheService {
  factory CacheService() => _sharedInstance();
  static CacheService? _instance;
  static SharedPreferences? sharedPreferences;
  CacheService._();
  static CacheService _sharedInstance() {
    if (_instance == null) {
      _instance = CacheService._();
    }
    return _instance!;
  }

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveData(String key, dynamic data) {
    switch (data.runtimeType) {
      case int:
        sharedPreferences?.setInt(key, data);
        break;
      case String:
        sharedPreferences?.setString(key, data);
        break;
      case bool:
        sharedPreferences?.setBool(key, data);
        break;
      case double:
        sharedPreferences?.setDouble(key, data);
        break;
      case List:
        sharedPreferences?.setStringList(key, data);
        break;
    }
  }

  static void deleteALL() {
    sharedPreferences?.clear();
  }

  static getData(String key) {
    return sharedPreferences?.get(key);
  }

  static bool checkExits(String key) {
    return sharedPreferences!.containsKey(key);
  }

  static void deleteData(String key, {bool? withConstans}) {
    if (withConstans != null) {
      var keys = sharedPreferences?.getKeys();
      keys!.forEach((realKey) {
        if (realKey.contains(key)) {
          sharedPreferences?.remove(realKey);
        }
      });
    } else {
      final exists = checkExits(key);
      if (exists) {
        sharedPreferences?.remove(key);
      }
    }
  }

  // Simulator 나 Emulator 에서는 네이트웍 상태 감지 못하기 때문에 Default true로 설정 합니다.
  static bool getNetworkState() {
    return getData('is_network_alive') ?? true;
  }

  static void saveIsLogin(String islogn) {
    saveData('is_login', islogn);
  }

  // static void saveIsLoginModel(IsLoginModel islogn) {
  //   saveData('is_login_model', jsonEncode(islogn.toJson()));
  // }

  // static IsLoginModel getIsLoginModel() {
  //   return IsLoginModel.fromJson(jsonDecode(getData('is_login_model')));
  // }

  static bool isUpdateAndNoticeCheckDone() {
    return getData('is_check_done') ?? false;
  }

  static void saveIsUpdateAndNoticeCheckDone(bool isCheckDone) {
    saveData('is_check_done', isCheckDone);
  }

  static bool isTValueDownLoadDone() {
    return getData('is_t_value_download_done') ?? false;
  }

  static void saveIsTValueDownLoadDone(bool isDone) {
    saveData('is_t_value_download_done', isDone);
  }

  static String? getIsLogin() {
    final result = getData('is_login');
    print('isLogin :: $result');
    return result;
  }

  static bool? canShowUpdatePageOnForegroud() {
    return getData('isDisable') ?? false;
  }

  static void setIsDisableUpdate(bool? isDisable) {
    saveData('isDisable', isDisable ?? false);
  }

  static bool? isDoExitAppInNextLifecycle(String pageName) {
    return getData('lifecycle_$pageName');
  }

  static void removeNextLifecycleStateAboutExitApp(String pageName) {
    deleteData('lifecycle_$pageName');
  }

  // static void setUserLogedIn(bool isLogedin) {
  //   saveData('is_loged_in', isLogedin);
  // }

  // static bool isUserLogedIn() {
  //   return getData('is_loged_in') ?? false;
  // }

  static void saveUser(User? user) {
    saveData('user', user != null ? jsonEncode(user.toJson()) : null);
  }

  static User? getUser() {
    var exists = checkExits('user');
    if (exists) {
      final user = getData('user');
      user as String;
      var json = jsonDecode(user);
      return User.fromJson(json);
    }
    return null;
  }

  static void deleteUserInfoWhenSignOut() {
    deleteData('user');
    deleteData('lifecycle_', withConstans: true);
    deleteData('isDisable');
    deleteData('is_login');
    deleteData('es_login');
    deleteData('is_loged_in');
    deleteData('is_check_done');
  }
}
