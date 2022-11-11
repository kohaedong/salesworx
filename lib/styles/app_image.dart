/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesworxm/lib/styles/app_image.dart
 * Created Date: 2021-11-19 07:48:11
 * Last Modified: 2021-11-19 07:49:01
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesworxm/enums/image_type.dart';

class AppImage {
  static getImage(ImageType imageType, {Color? color}) => SvgPicture.asset(
        imageType.path,
        color: color,
      );
}
