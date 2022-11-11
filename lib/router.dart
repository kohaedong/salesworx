/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/router.dart
 * Created Date: 2021-09-21 01:05:58
 * Last Modified: 2022-01-14 14:48:34
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:salesworxm/view/attach/attach_page.dart';
import 'package:salesworxm/view/commonLogin/common_login_page.dart';
import 'package:salesworxm/view/home/home_page.dart';
import 'package:salesworxm/view/settings/notice_setting_page.dart';
import 'package:salesworxm/view/settings/send_suggestions_page.dart';
import 'package:salesworxm/view/settings/settings_page.dart';
import 'package:salesworxm/view/signin/signin_page.dart';
import 'package:flutter/widgets.dart';

Map<String, WidgetBuilder> routes = {
  SigninPage.routeName: (context) => SigninPage(),
  HomePage.routeName: (context) => HomePage(),
  SettingsPage.routeName: (context) => SettingsPage(),
  NoticeSettingPage.routeName: (context) => NoticeSettingPage(),
  SendSuggestionPage.routeName: (context) => SendSuggestionPage(),
  CommonLoginPage.routeName: (context) => CommonLoginPage(),
  AttachPage.routeName: (context) => AttachPage(),
};
