// ignore_for_file: library_prefixes

/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/base_web_view.dart
 * Created Date: 2021-10-01 16:35:01
 * Last Modified: 2021-12-22 13:20:11
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inappWebVeiw;
import 'package:salesworxm/styles/app_colors.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/view/common/base_loading_view_on_stack_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaseWebView extends StatefulWidget {
  BaseWebView(this.url, {Key? key}) : super(key: key);
  final String? url;

  @override
  State<BaseWebView> createState() => _BaseWebViewState();
}

class _BaseWebViewState extends State<BaseWebView> {
  Completer<WebViewController>? _controller;
  static const MethodChannel _channel =
      const MethodChannel("mKolon.sso.channel");
  String? userAgent;
  Timer? timer;
  var swichShowWebView = ValueNotifier(false);
  Future<String> getUserAgent() async {
    if (Platform.isIOS) {
      return 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
    }
    final methodCallResult = await _channel.invokeMethod('userAgent') as String;
    this.userAgent = methodCallResult;
    return methodCallResult;
  }

  @override
  void initState() {
    _controller = Completer<WebViewController>();
    timer = Timer(Duration(milliseconds: 1500), () {
      swichShowWebView.value = true;
    });
    if (Platform.isAndroid) {
      inappWebVeiw.AndroidInAppWebViewController.setWebContentsDebuggingEnabled(
          true);
      WebView.platform = SurfaceAndroidWebView();
    }
    getUserAgent();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future<ContentsModel> initContents(String str, {double? scale}) async {
    if (str.startsWith('http')) {
      return ContentsModel(
          isStartWithHttp: true, isBase64: false, contents: str);
    } else {
      var temp = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=${scale != null ? '$scale' : '1.0'}"></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
        $str.
        </div>
      </body>
    </html>""";
      return ContentsModel(
          isStartWithHttp: false, isBase64: false, contents: temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContentsModel>(
        future: initContents('${widget.url}'),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isStartWithHttp
                ? ValueListenableBuilder<bool>(
                    valueListenable: swichShowWebView,
                    builder: (context, swich, _) {
                      return Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: swich ? 1 : 0,
                            duration: Duration(microseconds: 300),
                            child: Container(
                              width: AppSize.realWith,
                              height: AppSize.realHeight -
                                  AppSize.appBarHeight -
                                  AppSize.buttonHeight,
                              child: inappWebVeiw.InAppWebView(
                                  initialUrlRequest: inappWebVeiw.URLRequest(
                                    url:
                                        Uri.parse('${snapshot.data!.contents}'),
                                  ),
                                  initialOptions:
                                      inappWebVeiw.InAppWebViewGroupOptions(
                                    crossPlatform:
                                        inappWebVeiw.InAppWebViewOptions(
                                            preferredContentMode: inappWebVeiw
                                                .UserPreferredContentMode
                                                .MOBILE),
                                  )),
                            ),
                          ),
                          Positioned(
                              child: swich
                                  ? Container()
                                  : BaseLoadingViewOnStackWidget.build(
                                      context, true,
                                      color: AppColors.whiteText))
                        ],
                      );
                    })
                : ValueListenableBuilder<bool>(
                    valueListenable: swichShowWebView,
                    builder: (context, swich, _) {
                      return Stack(
                        children: [
                          AnimatedOpacity(
                              opacity: swich ? 1 : 0,
                              duration: Duration(microseconds: 300),
                              child: WebView(
                                userAgent: userAgent,
                                initialUrl: Uri.dataFromString(
                                        '${snapshot.data!.contents}',
                                        mimeType: 'text/html',
                                        encoding: Encoding.getByName('UTF-8'))
                                    .toString(),
                                javascriptMode: JavascriptMode.unrestricted,
                                gestureRecognizers: [
                                  Factory(
                                      () => VerticalDragGestureRecognizer()),
                                ].toSet(),
                                onWebViewCreated:
                                    (WebViewController webViewController) {
                                  _controller!.complete(webViewController);
                                },
                                onWebResourceError: (e) {
                                  print('Error ::: $e');
                                },
                              )),
                          Positioned(
                              child: swich
                                  ? Container()
                                  : BaseLoadingViewOnStackWidget.build(
                                      context, true,
                                      color: AppColors.whiteText))
                        ],
                      );
                    },
                  );
          }
          return BaseLoadingViewOnStackWidget.build(context, true,
              color: AppColors.whiteText);
        });
  }
}

class ContentsModel {
  String contents;
  bool isBase64;
  bool isStartWithHttp;
  ContentsModel(
      {required this.contents,
      required this.isBase64,
      required this.isStartWithHttp});
}
