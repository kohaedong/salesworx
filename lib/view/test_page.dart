/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesportal/lib/view/test/test_page.dart
 * Created Date: 2021-12-17 14:51:39
 * Last Modified: 2021-12-17 15:04:29
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);
  static const String routeName = '/testpage';
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    var aruments = ModalRoute.of(context)!.settings.arguments;
    Uint8List? uint8;
    if (aruments != null) {
      uint8 = aruments as Uint8List?;
    }
    return Container(
      child: uint8 != null
          ? Image.memory(Uint8List.view(uint8.buffer))
          : Container(),
    );
  }
}
