import 'dart:async';
import 'dart:io';
import 'package:salesworxm/enums/app_theme_type.dart';
import 'package:salesworxm/enums/hive_box_type.dart';
import 'package:salesworxm/model/buildConfig/kolon_build_config.dart';
import 'package:salesworxm/model/commonCode/common_code_response_model.dart';
import 'package:salesworxm/model/commonCode/es_return_model.dart';
import 'package:salesworxm/service/hive_service.dart';
import 'package:salesworxm/view/common/provider/app_theme_provider.dart';
import 'package:salesworxm/view/common/provider/water_marke_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salesworxm/enums/request_type.dart';
import 'package:salesworxm/model/http/token_model.dart';
import 'package:salesworxm/model/user/user.dart';
import 'package:salesworxm/model/user/user_settings.dart';
import 'package:salesworxm/service/api_service.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/service/deviceInfo_service.dart';
import 'package:salesworxm/service/navigator_service.dart';
import 'package:provider/provider.dart';

class SigninProvider extends ChangeNotifier {
  String errorMessage = '';
  String? userAccount;
  String? password;
  bool isCheckedSaveIdBox = false;
  bool isCheckedAutoSigninBox = false;
  User? user;
  bool? isFindKolonApps;
  bool isLoadData = false;
  UserSettings? userSettings;
  var _api = ApiService();
  static const MethodChannel iosPlatform = MethodChannel('kolonbase/keychain');
  static const MethodChannel androidPlatform =
      MethodChannel("mKolon.sso.channel");

  var buildType = '${KolonBuildConfig.KOLON_APP_BUILD_TYPE}';

  void setIdCheckBox() {
    this.isCheckedSaveIdBox = !isCheckedSaveIdBox;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> setDefaultData({String? id, String? pw}) async {
    Map<String, dynamic>? map = {};
    var isSavedId = await isSaveId();

    if (isSavedId) {
      print('saveID???$isSavedId');
      isCheckedSaveIdBox = true;
      if (id != null && pw != null) {
        map.putIfAbsent('id', () => id);
        map.putIfAbsent('pw', () => pw);
      } else {
        var account = await getIdonly();
        map.putIfAbsent('id', () => account);
      }
    }
    return map;
  }

  void setAutoSigninCheckBox() {
    this.isCheckedAutoSigninBox = !isCheckedAutoSigninBox;
    if (!this.isCheckedSaveIdBox) {
      this.isCheckedSaveIdBox = true;
    }
    notifyListeners();
  }

  void startErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void setAccount(String? str) {
    this.userAccount = (str == '' ? null : str);
    if (str == null || str.length == 1 || str == '') {
      notifyListeners();
    }
  }

  void setPassword(String? password) {
    this.password = (password == '' ? null : password);
    if (password == null || password.length == 1 || password == '') {
      notifyListeners();
    }
  }

  Future<TokenModel?> requestToken(String username, String password) async {
    Map<String, dynamic> tokenBody = {
      'username': username,
      'password': password,
      'grant_type': 'password',
      'scope': 'read',
      'client_id': 'default',
      'client_secret': 'secret'
    };

    _api.init(RequestType.REQEUST_TOKEN);
    final tokenResult = await _api.request(
      body: tokenBody,
    );

    if (tokenResult == null || tokenResult.statusCode != 200) {
      return null;
    }
    return TokenModel.fromJson(tokenResult.body);
  }

  Future<Map<String, dynamic>> getUserIdAndPasswordFromSSO() async {
    var tempResult = Platform.isIOS
        ? await getIosSSOLibUserData()
        : await getAndroidSSOLibUserData();
    return tempResult;
  }

  Future<bool> saveUserIdAndPasswordToSSO(
      String userAccount, String password) async {
    if (Platform.isIOS) {
      final idResult = await iosPlatform.invokeMethod('setUserId', userAccount);
      final passwordResult =
          await iosPlatform.invokeMethod('setUserPw', password);
      return idResult == 'success' && passwordResult == 'success';
    } else {
      final saveResult = await androidPlatform.invokeMethod(
          'saveIdAndPasswordToAndroidSSO', {
        'userAccount': '$userAccount',
        'password': '$password',
        'type': buildType
      });
      return saveResult == 'success';
    }
  }

  Future<bool> setIsSaveId(bool value) async {
    if (Platform.isIOS) {
      final idResult =
          await iosPlatform.invokeMethod('setIsSaveId', {"value": value});
      return idResult == 'success';
    }
    if (Platform.isAndroid) {
      final saveResult = await androidPlatform.invokeMethod(
          'setIsSaveId', {'isSaveId': value ? 'Y' : 'N', 'type': buildType});
      return saveResult == 'success';
    }
    return false;
  }

  Future<bool> isSaveId() async {
    if (Platform.isIOS) {
      return await iosPlatform.invokeMethod('isSaveId') as bool;
    } else {
      final result =
          await androidPlatform.invokeMethod('isSaveId', buildType) as String;
      return result == 'Y' ? true : false;
    }
  }

  Future<bool> isAutoLogin() async {
    if (Platform.isIOS) {
      return await iosPlatform.invokeMethod('isAutoLogin') as bool;
    } else {
      return androidPlatform
          .invokeMethod('isAutoLogin', buildType)
          .then((result) {
        result as String;
        return (result == 'Y' ? true : false);
      });
    }
  }

  Future<bool> setAutoLogin(bool value) async {
    if (Platform.isIOS) {
      final idResult =
          await iosPlatform.invokeMethod('saveAutoLogin', {"value": value});
      return idResult == 'success';
    }
    if (Platform.isAndroid) {
      final saveResult = await androidPlatform.invokeMethod('saveAutoLogin',
          {'isAutoLogin': value ? 'Y' : 'N', 'type': buildType});

      return saveResult == 'success';
    }
    return false;
  }

  Future<void> setIsWaterMarkeUser() async {
    if (Platform.isIOS) {
      MethodChannel iosPlatform = MethodChannel('kolonbase/keychain');
      var isShowWatermarkUser =
          await iosPlatform.invokeMethod('isShowWatermarkUser');
      var isAllowScreenshotUser =
          await iosPlatform.invokeMethod('isAllowScreenshotUser');
      print('isShowWatermarkUser:: $isShowWatermarkUser');
      print('isAllowScreenshotUser $isAllowScreenshotUser');
      if (isShowWatermarkUser) {
        final p = NavigationService.kolonAppKey.currentContext!
            .read<WaterMarkeProvider>();
        p.setShowWaterMarke(true);
      }
    }
  }

  Future<String?> getIdonly() async {
    String? id = '';
    if (Platform.isIOS) {
      id = await iosPlatform.invokeMethod('userId');
      return id;
    }
    if (Platform.isAndroid) {
      return await androidPlatform.invokeMethod('getIdOnly', buildType);
    }
  }

  Future<Map<String, dynamic>> getIosSSOLibUserData() async {
    try {
      final resultMap = await Future.delayed(Duration.zero, () async {
        final String? userAccount = await iosPlatform.invokeMethod('userId');
        final String? password = await iosPlatform.invokeMethod('userPw');
        final isLogedinOtherApps = userAccount != '' &&
            userAccount != null &&
            password != null &&
            password != '';
        return {
          'isLogedinOtherApps': isLogedinOtherApps,
          'userAccount': '$userAccount',
          'password': '$password'
        };
      });
      return resultMap;
    } catch (e) {
      print('$e');
      // emulator not support keychain.
      return {'isLogedinOtherApps': false};
    }
  }

  // Future<bool> findKolonApps() async {
  //   final findResult = await androidPlatform.invokeMethod(
  //       'findKolonApps', buildType) as String;
  //   print('isFind .....$findResult');

  //   return (findResult == 'success') ? true : false;
  // }

  Future<Map<String, dynamic>> getAndroidSSOLibUserData() async {
    try {
      final methodCallResult =
          await androidPlatform.invokeMethod('getSsoByAndroid', buildType);
      print(methodCallResult);
      if (methodCallResult['isLogedinOtherApps']) {
        return {
          'isLogedinOtherApps': true,
          'userAccount': methodCallResult['userAccount'],
          'password': methodCallResult['password']
        };
      }
    } catch (e) {
      return {
        'isLogedinOtherApps': false,
      };
    }
    return {
      'isLogedinOtherApps': false,
    };
  }

  bool get isValueNotNull => this.userAccount != null && this.password != null;

  Future<SigninResult> signIn({bool? isWithAutoLogin}) async {
    isLoadData = true;
    notifyListeners();
    Map<String, dynamic>? signBody;
    if (isWithAutoLogin != null && isWithAutoLogin) {
      var ssoResultMap = await getUserIdAndPasswordFromSSO();
      signBody = {
        "userAccount": "${ssoResultMap['userAccount']}",
        "passwd": "${ssoResultMap['password']}"
      };
    } else {
      signBody = {"userAccount": userAccount ?? '', "passwd": password ?? ''};
    }
    _api.init(RequestType.SIGNIN);
    final signResult = await _api.request(body: signBody);

    print(signResult!.body);
    if (signResult.statusCode == 200 && signResult.body['code'] == "NG") {
      isLoadData = false;
      notifyListeners();
      return SigninResult(false, "${tr('check_account')}");
    }

    if (signResult.statusCode == 200 && signResult.body['data'] != null) {
      user = User.fromJson(signResult.body['data']);
      final tokenResult =
          await requestToken(signBody['userAccount'], signBody['passwd']);

      if (tokenResult != null) {
        user!.tokenInfo = tokenResult;
        CacheService.saveUser(user!);
      } else {
        isLoadData = false;
        notifyListeners();
        return SigninResult(false, "token faild");
      }
      // id저장 checkBox 선택했을때
      if (isWithAutoLogin == null) {
        setAutoLogin(isCheckedAutoSigninBox);
        setIsSaveId(isCheckedSaveIdBox);
      }
      saveUserIdAndPasswordToSSO(signBody['userAccount'], signBody['passwd']);
      final result = await getDeviceInfo(signBody['userAccount']);
      if (result.isSuccessful) {
        // ------------ save  Environments ---------
        final envnResult = await checkUserEnvironment(signBody['userAccount']);
        if (envnResult != null) {
          var saveEvenResult =
              await saveUserEven(envnResult, signBody['userAccount']);
          if (saveEvenResult) {
            var type = getThemeType(envnResult.textScale!);
            NavigationService.kolonAppKey.currentContext!
                .read<AppThemeProvider>()
                .setThemeType(type);
            setIsWaterMarkeUser();

            isLoadData = false;
            notifyListeners();
            return SigninResult(true, 'ok');
          }
        }
      }
    }
    isLoadData = false;
    notifyListeners();
    return SigninResult(false, "");
  }

  Future<UserSettings?> checkUserEnvironment(String userAccount) async {
    Map<String, dynamic> _body = {
      "methodName": RequestType.GET_ENV.serverMethod,
      "methodParam": {
        "categoryCode": "envKey_$userAccount",
      }
    };
    _api.init(RequestType.GET_ENV);

    final envResult = await _api.request(body: _body);
    if (envResult!.body['code'] != 'NG') {
      if (envResult.body['data'] != null) {
        final temp =
            UserSettings.fromJson(envResult.body['data']['description']);
        print('from server! user Env ${temp.toJson()}');
        return temp;
      } else {
        print('new userSettings');
        final temp = UserSettings(
          isSetNotDisturb: true,
          isShowNotice: true,
          notDisturbStartHour: '',
          notDisturbStartMine: '',
          notDisturbStopHour: '',
          notDisturbStopMine: '',
          textScale: 'medium',
        );
        return temp;
      }
    }
  }

  Future<bool> saveUserEven(
      UserSettings passingUserSettings, String userAccount) async {
    var _api = ApiService();
    Map<String, dynamic> saveEnvBody = {
      "methodName": RequestType.SAVE_ENV.serverMethod,
      "methodParam": {
        "categoryCode": "envKey_$userAccount",
        "description": passingUserSettings.toJson()
      }
    };
    _api.init(RequestType.SAVE_ENV);
    final envRequest = await _api.request(body: saveEnvBody);
    if (envRequest!.statusCode == 200) {
      print('save Env successful ${envRequest.body}');
      return true;
    }
    return false;
  }

  Future<SigninResult> getDeviceInfo(String account) async {
    final deviceInfo = await DeviceInfoService.getDeviceInfo();
    print(deviceInfo.toJson());
    Map<String, dynamic> deviceInfoBody = {
      "methodName": RequestType.SAVE_DEVICE_INFO.serverMethod,
      "methodParam": {
        "deviceId": deviceInfo.deviceId,
        "deviceModelNo": deviceInfo.deviceModel,
        "devicePlatformName": Platform.isIOS ? 'iOS' : 'Android',
        "userId": account
      }
    };

    _api.init(RequestType.SAVE_DEVICE_INFO);
    final deviceInfoResult = await _api.request(body: deviceInfoBody);
    if (deviceInfoResult == null && deviceInfoResult!.statusCode != 200) {
      return SigninResult(false, 'Device not register');
    }
    if (deviceInfoResult.statusCode == 200) {
      return SigninResult(true, 'Device register successful');
    }
    return SigninResult(false, 'Device not register');
  }
}

class SigninResult {
  bool isSuccessful;
  String message;
  String? id;
  String? pw;
  bool? isShowPopup;
  SigninResult(this.isSuccessful, this.message,
      {this.id, this.pw, this.isShowPopup});
}
