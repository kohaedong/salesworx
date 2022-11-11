/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/api_service.dart
 * Created Date: 2021-08-22 21:53:15
 * Last Modified: 2022-01-14 17:03:57
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:convert';
import 'dart:io';
import 'package:salesworxm/model/buildConfig/kolon_build_config.dart';
import 'package:salesworxm/service/local_file_servicer.dart';
import 'package:salesworxm/util/encoding_util.dart';
import 'package:salesworxm/util/log_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:salesworxm/enums/request_type.dart';
import 'package:salesworxm/model/http/request_result.dart';
import 'package:salesworxm/model/http/token_model.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/service/deviceInfo_service.dart';
import 'package:salesworxm/service/navigator_service.dart';
import 'package:salesworxm/view/common/app_dialog.dart';

typedef HttpSuccessCallback<T> = void Function(dynamic data);

typedef DownLoadCallBack = Function(int, int);
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class ApiService {
  Map<String, CancelToken?> _cancelTokens = Map<String, CancelToken?>();
  Dio? _client;
  RequestType? requestType;
  final isWithLog = false;
  final String _clientID = 'default';
  final String _clientSecret = 'secret';
  CookieJar? cookieJar;
  List<Cookie>? responseCookies;
  List<Cookie>? requestcookies;
  String? currentUrl;
  int errorCount = 0;
  bool isNetworkError = false;
  Dio get client => _client!;
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    if (_client == null) {
      cookieJar = CookieJar();
      final _baseOption = BaseOptions(
          connectTimeout: 50000,
          receiveTimeout: 50000,
          sendTimeout: 50000,
          contentType: 'application/json');
      _client = Dio(_baseOption)
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: onRequestWrapper,
            onResponse: onResponseWrapper,
            onError: onErrorWrapper,
          ),
        )
        ..interceptors.add(CookieManager(cookieJar!));
      (_client!.transformer as DefaultTransformer).jsonDecodeCallback =
          parseJson;
    }
  }

  void init(RequestType type) async {
    requestType = type;
  }

  bool isDifferentCurrentUrl(String url) {
    return url != currentUrl;
  }

  onRequestWrapper(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final deviceInfo = await DeviceInfoService.getDeviceInfo();
    final header = {
      'deviceSerialNo': deviceInfo.deviceId,
      'deviceModelNo': deviceInfo.deviceModel,
      'appId': Platform.isIOS
          //빌드옵션
          ? '1555'
          : '1554',
    };
    final anotherHeader = await requestType!.anotherHeader;
    options.headers.addAll(header);
    if (anotherHeader.isNotEmpty) {
      options.headers.addAll(anotherHeader);
    }
    if (requestType!.isWithAccessToken) {
      final user = CacheService.getUser();
      if (user != null) {
        options.headers.addAll({
          'Authorization': 'Bearer ${user.tokenInfo!.accessToken}',
        });
      }
    } else {
      if (requestType == RequestType.REFRESHE_TOKEN ||
          requestType == RequestType.REQEUST_TOKEN) {
        final token =
            EncodingUtils.encodeBase64(str: '$_clientID:$_clientSecret');
        options.headers.addAll({
          'Authorization': 'Basic $token',
        });
      }
    }

    if (isWithLog) {
      customLogger.d(
        '!!!!!!!!!!REQUEST RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
        'path: ${options.baseUrl}${options.path}\n'
        'headers: ${options.headers}'
        'body: ${options.data}\n',
      );
    }
    print(options.data);
    return handler.next(options);
  }

  onResponseWrapper(Response resp, ResponseInterceptorHandler handler) async {
    // 토큰 갱신 플로우.
    if (resp.statusCode == 419) {
      var user = await CacheService.getUser();
      if (user != null) {
        final body = {
          'refresh_token': user.tokenInfo!.refreshToken,
          'grant_type': 'refresh_token'
        };
        ApiService()
          ..init(RequestType.REFRESHE_TOKEN)
          ..request(body: body).then((result) {
            if (result!.statusCode == 200) {
              var tokenModel = TokenModel.fromJson(result.body);
              user.tokenInfo = tokenModel;
              CacheService.saveUser(user);
            }
          });
      }
    }
    print(requestType);

    if (isWithLog) {
      customLogger.d(
        '!!!!!!!!!!RESPONSE RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
        'path: ${resp.requestOptions.baseUrl}${resp.requestOptions.path}\n'
        'headers: ${resp.headers}'
        'body: ${resp.data}\n',
      );
    }
    return handler.next(resp);
  }

  onErrorWrapper(DioError error, ErrorInterceptorHandler handler) async {
    errorCount++;

    if (isWithLog) {
      customLogger.d(
        'XXXXXXXXX ERROR THROWN WITH FOLLOWING LOGXXXXXXXXXXX\n'
        'path: ${error.requestOptions.baseUrl}${error.requestOptions.path}\n'
        'status code: ${error.response?.statusCode ?? ''}\n'
        'body: ${error.response?.data.toString() ?? ''}\n'
        'headers: ${error.response?.headers ?? ''}\n'
        'requestType: $requestType',
      );
    }
    //  ------------  error prossess -------------
    print(errorCount);
    print('error count ::$errorCount');
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isNetworkError = true;
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          isNetworkError = false;
        }
      });
      await AppDialog.showNetworkErrorDialog(
          NavigationService.kolonAppKey.currentContext!);
      handler.next(error);
    } else {
      final result = await AppDialog.showServerErrorDialog(
          NavigationService.kolonAppKey.currentContext!);
      if (errorCount > 3) {
        if (result != null) {
          CacheService.deleteUserInfoWhenSignOut();
          exit(0);
        }
      } else {
        handler.next(error);
      }
    }
  }

  Future<File?> downloadAndroid(String url, String dirPath,
      DownLoadCallBack onReceiveProgress, String filePath) async {
    File file = await LocalFileService().createFile(filePath);
    try {
      Response response = await Dio().get(url,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          ));

      file.writeAsBytesSync(response.data);
      return file;
    } catch (e) {
      print(e);
    }
  }

  void upload(
      {required String? url,
      FormData? data,
      ProgressCallback? onSendProgress,
      Map<String, dynamic>? params,
      Options? options,
      HttpSuccessCallback? successCallback,
      required String? tag}) async {
    try {
      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag]!;
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _client!.request('',
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      String statusCode = response.data!['statusCode'];
      if (statusCode != '200') {
        // do something;
      }
    } on DioError catch (e, s) {
      print(s);
    } catch (e) {}
  }

  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]!.cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  void cancelAll() {
    _cancelTokens.forEach((key, cancelToken) {
      cancelToken!.cancel();
    });
  }

  Future<RequestResult?> request({
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    final CancelToken? cancelToken;
    final tag = requestType!.tag;
    cancelToken = _cancelTokens[tag] ?? CancelToken();
    _cancelTokens[tag] = cancelToken;
    //* 사용자 휴대폰 넷트워크 에러시 ErrorDialog 호출.
    final isAlive = CacheService.getNetworkState();
    if (!isAlive) {
      return RequestResult(0, {}, '', errorMessage: 'networkError');
    }
    if (requestType!.httpMethod == 'POST' || requestType!.httpMethod == 'GET') {
      try {
        final Response<Map<String, dynamic>> response = await _client!.request(
            requestType!.url(),
            data: requestType!.httpMethod == 'POST' ? jsonEncode(body) : null,
            queryParameters: requestType!.httpMethod == 'GET' ? params : null,
            options: Options(
              method: requestType!.httpMethod,
            ),
            cancelToken: cancelToken);
//------------ cookies setting ----------
        // responseCookies = await cookieJar!
        //     .loadForRequest(Uri.parse('${RequestType.REQEUST_TOKEN.url()}'));
        // responseCookies!.forEach((cookie) {});
        // await cookieJar!.saveFromResponse(
        //     Uri.parse(RequestType.SIGNIN.url()), responseCookies!);
        // final signincookies = await cookieJar!
        //     .loadForRequest(Uri.parse(RequestType.SIGNIN.url()));
        // signincookies.forEach((cookie) {});
//------------ cookies setting ----------

        return RequestResult(
            response.statusCode!, response.data, response.statusMessage!);
      } on DioError catch (e, s) {
        //*  요청 켄슬.
        cancel(tag);
        print(s);
        print(e.response);
        // * 서버 통신 장애시 statusCode -1로 리턴.
        return RequestResult(-1, {}, '', errorMessage: 'serverError');
      }
    }
    //*  알수없는 에러시 statusCode 0 으로 리턴.
    return RequestResult(0, {}, 'anothor error');
  }
}
