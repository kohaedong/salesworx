import 'package:salesworxm/model/commonCode/et_dd07v_customer_category_model.dart';
import 'package:salesworxm/model/commonCode/t_code_model.dart';
import 'package:salesworxm/model/commonCode/t_values_model.dart';
import 'package:salesworxm/router.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/service/navigator_service.dart';
import 'package:salesworxm/util/screen_captrue_util.dart';
import 'package:salesworxm/view/common/provider/app_theme_provider.dart';
import 'package:salesworxm/view/common/provider/water_marke_provider.dart';
import 'package:salesworxm/view/commonLogin/common_login_page.dart';
import 'package:salesworxm/view/commonLogin/provider/notice_index_provider.dart';
import 'package:salesworxm/view/settings/provider/settings_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  ScreenCaptrueUtil.screenListen();
  Hive.registerAdapter(TCodeModelAdapter());
  Hive.registerAdapter(TValuesModelAdapter());
  Hive.registerAdapter(EtDd07vCustomerModelAdapter());

  await CacheService.init();
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
        child: MyApp(),
        supportedLocales: [Locale("ko")],
        path: "assets/location",
        fallbackLocale: Locale("ko"),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(366, 640),
        builder: () => MultiProvider(
                providers: [
                  ChangeNotifierProvider<AppThemeProvider>(
                    create: (context) => AppThemeProvider(),
                  ),
                  ChangeNotifierProvider<SettingsProvider>(
                    create: (_) => SettingsProvider(),
                  ),
                  ChangeNotifierProvider<WaterMarkeProvider>(
                    create: (_) => WaterMarkeProvider(),
                  ),
                  ChangeNotifierProvider<NoticeIndexProvider>(
                    create: (_) => NoticeIndexProvider(),
                  ),
                ],
                child: Builder(builder: (context) {
                  return RepaintBoundary(
                    key: NavigationService.screenKey,
                    child: MaterialApp(
                        navigatorKey: NavigationService.kolonAppKey,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        debugShowCheckedModeBanner: false,
                        theme: context.read<AppThemeProvider>().themeData,
                        home: CommonLoginPage(),
                        routes: routes),
                  );
                })));
  }
}
