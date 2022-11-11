import 'dart:io';

import 'package:salesworxm/enums/request_type.dart';
import 'package:salesworxm/model/update/check_update_model.dart';
import 'package:salesworxm/model/user/user.dart';
import 'package:salesworxm/model/user/user_settings.dart';
import 'package:salesworxm/service/api_service.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/view/commonLogin/provider/update_and_notice_provider.dart';
import 'package:salesworxm/view/signin/provider/signin_provider.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  UserSettings? settings;
  CheckUpdateModel? updateInfo;
  bool? notdisturbSwichValue;
  bool? noticeSwichValue;
  String? textScale;
  String? notDisturbStartHour;
  String? notDisturbStartMinute;
  String? notDisturbEndHour;
  String? notDisturbEndMinute;
  String? suggetionText;
  final List<String> _timePickerHourList = [];
  final List<String> _timePickerminuteList = [];

  Future<SettingsResult> init() async {
    final user = CacheService.getUser();
    await initData();
    await checkUpdate();
    return SettingsResult(true,
        updateInfo: updateInfo, settings: settings, user: user);
  }

  Future<SettingsResult> initData() async {
    settings = await getUserEvn();
    noticeSwichValue = settings!.isShowNotice;
    notdisturbSwichValue = settings!.isSetNotDisturb;
    notDisturbStartHour = settings!.notDisturbStartHour;
    notDisturbStartMinute = settings!.notDisturbStartMine;
    notDisturbEndHour = settings!.notDisturbStopHour;
    notDisturbEndMinute = settings!.notDisturbStopMine;
    textScale = settings!.textScale;
    return SettingsResult(true, settings: settings);
  }

  void setSettingsScale(String scale) {
    this.settings!.textScale = scale;
  }

  Future<void> checkUpdate() async {
    final result = await UpdateAndNoticeProvider().checkUpdate();
    updateInfo = result.updateData!.model;
  }

  List<String> get timePickerHourList {
    if (_timePickerHourList.isEmpty) {
      for (var i = 0; i < 24; i++) {
        if (i < 10) {
          _timePickerHourList.add('0$i');
        } else {
          _timePickerHourList.add('$i');
        }
      }
    }
    return this._timePickerHourList;
  }

  List<String> get timePickerminuteList {
    if (_timePickerminuteList.isEmpty) {
      for (var i = 0; i < 60; i++) {
        if (i < 10) {
          _timePickerminuteList.add('0$i');
        } else {
          _timePickerminuteList.add('$i');
        }
      }
    }
    return this._timePickerminuteList;
  }

  setNotdisturbSwichValue(bool value) {
    this.notdisturbSwichValue = value;
    settings!.isSetNotDisturb = value;
    notifyListeners();
  }

  setNoticeSwichValue(bool value) {
    this.noticeSwichValue = value;
    settings!.isShowNotice = value;
    notifyListeners();
  }

  setNotDisturbStartHourValue(String hour) {
    this.notDisturbStartHour = hour;
    settings!.notDisturbStartHour = hour;
    notifyListeners();
  }

  setNotDisturbStartMinuteValue(String minute) {
    this.notDisturbStartMinute = minute;
    settings!.notDisturbStartMine = minute;
    notifyListeners();
  }

  setNotDisturbEndHourValue(String hour) {
    this.notDisturbEndHour = hour;
    settings!.notDisturbStopHour = hour;
    notifyListeners();
  }

  setNotDisturbEndMinuteValue(String minute) {
    this.notDisturbEndMinute = minute;
    settings!.notDisturbStopMine = minute;
    notifyListeners();
  }

  setSuggestion(String text) {
    this.suggetionText = text;
    notifyListeners();
  }

  bool get isSuggestionTextNotEmpty =>
      suggetionText != null && suggetionText!.isNotEmpty && suggetionText != '';

  Future<bool> saveUserEvn() async {
    final user = CacheService.getUser();
    return await SigninProvider()
        .saveUserEven(settings!, user!.userAccount!.toLowerCase());
  }

  Future<UserSettings?> getUserEvn() async {
    final user = CacheService.getUser();
    return await SigninProvider()
        .checkUserEnvironment(user!.userAccount!.toLowerCase());
  }

  Future<bool> sendSuggestion() async {
    final user = await CacheService.getUser();
    final _body = {
      "methodName": RequestType.SEND_SUGGETION.serverMethod,
      "methodParam": {
        "appId": Platform.isIOS ? '2' : '1',
        "appOpnnExpsrYn": "Y",
        "revicwDscr": "$suggetionText",
        "userId": "${user!.userAccount}"
      }
    };
    var _api = ApiService();
    _api.init(RequestType.SEND_SUGGETION);
    final result = await _api.request(body: _body);
    if (result == null || result.statusCode != 200) {
      return false;
    }
    if (result.statusCode == 200 || result.body['code'] == 'OK') {
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await SigninProvider()
        .setAutoLogin(false)
        .then((value) => print('setAutoLogin to $value'));
  }
}

class SettingsResult {
  bool isSuccessful;
  CheckUpdateModel? updateInfo;
  UserSettings? settings;
  User? user;
  SettingsResult(this.isSuccessful,
      {this.updateInfo, this.settings, this.user});
}
