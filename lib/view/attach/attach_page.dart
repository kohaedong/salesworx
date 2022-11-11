import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:salesworxm/model/http/API.dart';
import 'package:salesworxm/styles/app_style.dart';
import 'package:salesworxm/styles/app_text_style.dart';
import 'package:salesworxm/view/common/app_bar.dart';
import 'package:salesworxm/view/common/base_layout.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:crypto/crypto.dart' as crypto;

class AttachPage extends StatefulWidget {
  static const String routeName = '/attach';
  @override
  _AttachPageState createState() => _AttachPageState();
}

class _AttachPageState extends State<AttachPage> {
  WebViewController? _webViewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String? _sUrl;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      disableCapture();
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    String? attachKey;
    if (arguments != null) {
      arguments as Map<String, dynamic>;
      attachKey = arguments['key'];
    }
    _sUrl =
        '${API.ATTACH_URL}' '${attachKey}' '&contextPath=/SynapDocViewServer';

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return BaseLayout(
      hasForm: true,
      appBar: MainAppBar(context,
          titleText: AppStyles.text('${tr('settings')}', AppTextStyle.w500_20)),
      child: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: _sUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.future.then((value) => _webViewController = value);
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        );
      }),
    );
  }

  Future disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}
