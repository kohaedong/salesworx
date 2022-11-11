/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/model/rfc/et_dd07v_customer_category_response_model.dart
 * Created Date: 2021-09-29 11:56:54
 * Last Modified: 2021-09-29 12:08:20
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */
import 'package:json_annotation/json_annotation.dart';

import './et_dd07v_customer_category_model.dart';
part 'et_dd07v_customer_category_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EtDd07vCustomerCategoryResponseModel {
  @JsonKey(name: 'ET_DD07V_TAB')
  List<EtDd07vCustomerModel>? modelList;
  EtDd07vCustomerCategoryResponseModel(this.modelList);

  factory EtDd07vCustomerCategoryResponseModel.fromJson(Object? json) =>
      _$EtDd07vCustomerCategoryResponseModelFromJson(
          json as Map<String, dynamic>);

  Map<String, dynamic> toJson() =>
      _$EtDd07vCustomerCategoryResponseModelToJson(this);
}
