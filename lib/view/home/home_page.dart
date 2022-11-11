import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:salesworxm/enums/image_type.dart';
import 'package:salesworxm/model/http/API.dart';
import 'package:salesworxm/model/user/user.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/styles/app_image.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/util/encoding_util.dart';
import 'package:salesworxm/view/attach/attach_page.dart';
import 'package:salesworxm/view/common/app_dialog.dart';
import 'package:salesworxm/view/common/app_toast.dart';
import 'package:salesworxm/view/settings/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:salesworxm/model/http/http_request.dart';

String? initUrl;

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController? _webViewController;

  String _sUrl = 'https://benettonmall.com';
  //String _sUrl = 'https://mdevsalesworx.kolon.com/sys/login/mobileSSO?hash=';
  String? userId;
  num position = 1;
  bool isLoading = false;
  Timer? exitAppTimer;
  late DateTime backbuttonpressedTime;

  final _request = HttpRequest(API.BASE_URL);
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      disableCapture();
      WebView.platform = SurfaceAndroidWebView();
    }

    User? user;
    user = CacheService.getUser();
    var userId = 'kolonmobile@''${user?.userAccount}';
    var hashCode = crypto.md5.convert(utf8.encode(userId)).toString();

    var datetimeFormatter = new DateFormat('yyyyMMddHHmmss');
    var curDateTime = datetimeFormatter.format(DateTime.now());

    var base64 = '$curDateTime' '@' '$hashCode';
    var encodingLoginInfor = EncodingUtils.encodeBase64(str: base64);
    //initUrl = '$_sUrl''$encodingLoginInfor';
    initUrl = 'https://benettonmall.com';
    print('URL: $initUrl');
  }

  @override
  void dispose() {
    super.dispose();
    if (exitAppTimer != null) {
      exitAppTimer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        /*
        appBar: AppBar(
          title: const Text(
            'SalesWorX',
          ),
          actions: <Widget>[
            ActionbarControls(_controller.future),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        */
        bottomNavigationBar: BottomAppBar(
          child: NavigationControls(_controller.future),
        ),
        body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return Stack(
          children: <Widget> [
            WebView(
            initialUrl: initUrl,
            // zoomEnabled: false,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.future.then((value) => _webViewController = value);
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (value) {setState(() {
              isLoading = true;
            });
            },
            onPageFinished: (value) {setState(() {
              isLoading = false;
            });
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
            isLoading ? Center(child: CircularProgressIndicator(),) : Stack(),
          ],
          );
        }),
      ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    /// fid=test&filePath=http://ndeviken.kolon.com/data/brochure/KOLON_Brochure_Korean.pdf
    return JavascriptChannel(
        name: 'webToAppKolon',
        onMessageReceived: (JavascriptMessage message) async {
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(message.message)),);
          await attachRequest(message.message);
        });
  }

  // 첨부파일 변환 요청 API 호출
  Future<void> attachRequest(String? str) async {
    int? pos = str?.lastIndexOf(".");
    String? ext = str?.substring(pos! + 1);

    bool exists = await _checkAttachExt(ext!);
    if (!exists) {
      AppDialog.showSignglePopup(context, '${tr('no_support_attach')}');
    } else {
      var _filePath = '${API.BASE_URL}' '$str';
      var dio = Dio();
      final response = await dio.get(_filePath);
      print(response.data);
      var attachKey = response.data['key'];
      // 첨부파일 웹뷰 화면 호출
      Navigator.pushNamed(context, AttachPage.routeName,
          arguments: {'key': attachKey});
    }
  }

  Future<bool> _checkAttachExt(String strExt) async {
    switch(strExt.toUpperCase()) {
      case "HTML": case "MHT": case "MHML": case "HWP": case "HML": case "HWX":case "DOCX": case "DOCM": case "DOTM": case "PPTX":
      case "PPTM": case "POTX": case "POTM": case "PPSX": case "THMX": case "XLSX": case "XLSM": case "XLTX": case "XLTM": case "XLSB":
      case "DOC": case "DOT": case "DOTX": case "PPT": case "POT": case "PPS": case "XLS": case "XLT": case "TXT": case "CSV": case "XML":
      case "BMP": case "GIF": case "JPEG": case "JPG": case "PNG": case "TIFF": case "ODT": case "PDF":
        break;
      default:
        return false;
    }
    return true;
  }

  Future<bool> _goBack(BuildContext context) async {
    if (_webViewController == null) {
      return true;
    }
    if (await _webViewController!.canGoBack()) {
      _webViewController!.goBack();
      return Future.value(false);
    } else {
      if (exitAppTimer == null) {
        exitAppTimer = Timer(Duration(seconds: 3), () {});
        AppToast().show(context, '${tr('ext_app_when_tap_again')}');
      } else {
        if (exitAppTimer!.isActive) {
          exit(0);
        } else {
          exitAppTimer = Timer(Duration(seconds: 3), () {});
          AppToast().show(context, '${tr('ext_app_when_tap_again')}');
        }
      }
      return false;
    }
  }

  Future disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}

class ActionbarControls extends StatelessWidget {
  const ActionbarControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;
  final String c4cUrlSchema = 'c4cex://';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            InkWell(
                onTap: () async {
                  // C4C 호출
                  if(await canLaunch(c4cUrlSchema)) {
                    await launch(c4cUrlSchema);
                  } else {
                    throw 'Could not launch $c4cUrlSchema';
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(right: AppSize.padding),
                  child: SizedBox(
                      height: AppSize.homeAppBarSettingIconHeight,
                      child: AppImage.getImage(ImageType.SEARCH)),
                )),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: AppSize.padding),
                  child: SizedBox(
                      height: AppSize.homeAppBarSettingIconHeight,
                      child: AppImage.getImage(ImageType.SETTINGS_ICON)),
                ))
          ],
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    controller?.goBack();
                  },
                ),
                ElevatedButton(
                  child: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    controller?.goForward();
                  },
                ),
                ElevatedButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () {
                    controller?.reload();
                  },
                ),
                ElevatedButton(
                  child: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, SettingsPage.routeName);
                  },
                ),
              ],
            );
      },
    );
  }
}

// --dart-define=KOLON_BUNDLE_ID=com.kolon.salesportaldev --dart-define=KOLON_APP_VERSION_NAME=01.00.00 --dart-define=KOLON_APP_VERSION_CODE=90000000 --dart-define=KOLON_APP_BASE_URL=https://appdev.kolon.com --dart-define=KOLON_APP_V2_URL=https://appdev.kolon.com/common/v2/api --dart-define=KOLON_APP_RFC_URL=https://appdev.kolon.com/sales-group/rfc --dart-define=KOLON_APP_SALES_PORTAL_URL=https://appdev.kolon.com/sales-group/salesportal --dart-define=KOLON_APP_SIGNIN_URL=https://appdev.kolon.com/common/v2/api/basiclogin/auth --dart-define=KOLON_APP_BUILD_TYPE=dev --dart-define=KOLON_APP_IOS_COMPANY_CODE=KOLONDEV --dart-define=KOLON_APP_IOS_ID=1555 --dart-define=KOLON_APP_ANDROID_ID=1554
