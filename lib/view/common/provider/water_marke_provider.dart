/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesworxm/lib/view/common/provider/water_marke_provider.dart
 * Created Date: 2021-12-17 15:52:56
 * Last Modified: 2021-12-22 12:58:52
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:flutter/material.dart';

class WaterMarkeProvider extends ChangeNotifier {
  bool isShowWaterMarke = false;
  setShowWaterMarke(bool value) {
    this.isShowWaterMarke = value;
    notifyListeners();
  }
}
