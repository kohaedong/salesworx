/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/enums/image_type.dart
 * Created Date: 2021-08-20 14:37:40
 * Last Modified: 2021-11-19 08:25:33
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

enum ImageType {
  SPLASH_ICON,
  TEXT_LOGO,
  APP_SALES_ORDER,
  APP_SALES_OPPORTUNITY,
  APP_SALES_APPROVAL,
  APP_ORDER_DO,
  APP_MONITORING,
  APP_INVENTORY,
  APP_CONSULTING,
  APP_PROFILE,
  APP_OPPORTUNITY,
  APP_CUSTOMER_MANAGER,
  APP_AGENCY,
  SETTINGS_ICON,
  EMPTY,
  SEARCH,
  SELECT,
  DELETE,
  DATA_PICKER,
  PLUS,
  MENU,
  PLUS_SMALL,
  INFO
}

extension RequestTypeExtension on ImageType {
  String get path {
    switch (this) {
      case ImageType.SPLASH_ICON:
        return 'assets/images/icon_app_sales.svg';
      case ImageType.TEXT_LOGO:
        return 'assets/images/kolon_logo.svg';
      case ImageType.APP_AGENCY:
        return 'assets/images/icon_app_agency.svg';
      case ImageType.APP_CUSTOMER_MANAGER:
        return 'assets/images/icon_app_c_manager.svg';
      case ImageType.APP_OPPORTUNITY:
        return 'assets/images/icon_app_c_opportunity.svg';
      case ImageType.APP_PROFILE:
        return 'assets/images/icon_app_c_profile.svg';
      case ImageType.APP_CONSULTING:
        return 'assets/images/icon_app_consulting.svg';
      case ImageType.APP_INVENTORY:
        return 'assets/images/icon_app_inventory.svg';
      case ImageType.APP_MONITORING:
        return 'assets/images/icon_app_monitoring.svg';
      case ImageType.APP_ORDER_DO:
        return 'assets/images/icon_app_order_do.svg';
      case ImageType.APP_SALES_APPROVAL:
        return 'assets/images/icon_app_sales_approval.svg';
      case ImageType.APP_SALES_OPPORTUNITY:
        return 'assets/images/icon_app_sales_opportunity.svg';
      case ImageType.APP_SALES_ORDER:
        return 'assets/images/icon_app_sales_order.svg';
      case ImageType.EMPTY:
        return 'assets/images/empty.svg';
      case ImageType.SETTINGS_ICON:
        return 'assets/images/icon_outlined_24_lg_1_settings.svg';
      case ImageType.SEARCH:
        return 'assets/images/icon_outlined_18_lg_3_search.svg';
      case ImageType.SELECT:
        return 'assets/images/icon_outlined_18_lg_3_down.svg';
      case ImageType.DELETE:
        return 'assets/images/icon_filled_18_lg_3_misuse.svg';
      case ImageType.DATA_PICKER:
        return 'assets/images/icon_outlined_18_lg_3_calendar.svg';
      case ImageType.PLUS:
        return 'assets/images/icon_outlined_24_lbp_3_add.svg';
      case ImageType.MENU:
        return 'assets/images/icon_outlined_24_lg_3_menu.svg';
      case ImageType.PLUS_SMALL:
        return 'assets/images/icon_outlined_18_lg_3_add.svg';
      case ImageType.INFO:
        return 'assets/images/icon_outlined_24_lg_3_warning.svg';

      default:
        return '';
    }
  }
}
