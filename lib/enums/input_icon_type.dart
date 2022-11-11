/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/enums/input_icon_type.dart
 * Created Date: 2021-09-05 17:34:24
 * Last Modified: 2022-01-14 14:55:12
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:flutter/material.dart';
import 'package:salesworxm/enums/image_type.dart';
import 'package:salesworxm/styles/app_image.dart';

enum InputIconType {
  SEARCH,
  SELECT,
  DELETE_AND_SEARCH,
  DATA_PICKER,
  DELETE,
}

extension InputIconTypeExtension on InputIconType {
  Widget icon({Function? callback1, Function? callback2, Color? color}) {
    switch (this) {
      case InputIconType.SEARCH:
        return AppImage.getImage(ImageType.SEARCH, color: color);
      case InputIconType.SELECT:
        return AppImage.getImage(ImageType.SELECT, color: color);
      case InputIconType.DELETE_AND_SEARCH:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () => callback2!.call(),
                child: AppImage.getImage(ImageType.DELETE, color: color)),
            SizedBox(width: 5),
            InkWell(
              onTap: () => callback1!.call(),
              child: AppImage.getImage(ImageType.SEARCH, color: color),
            ),
          ],
        );
      case InputIconType.DATA_PICKER:
        return AppImage.getImage(ImageType.DATA_PICKER, color: color);
      case InputIconType.DELETE:
        return AppImage.getImage(ImageType.DELETE, color: color);
    }
  }
}
