/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/kolonFile/salesworxm/lib/model/commonCode/common_code_response_model.dart
 * Created Date: 2022-01-15 18:51:26
 * Last Modified: 2022-01-15 18:53:38
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2022  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:salesworxm/model/commonCode/es_return_model.dart';
import 'package:salesworxm/model/commonCode/t_code_model.dart';
import 'package:salesworxm/model/commonCode/t_values_model.dart';
part 'common_code_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommonCodeResponseModel {
  @JsonKey(name: 'ES_RETURN')
  EsReturnModel? esReturn;
  @JsonKey(name: 'T_CODE')
  List<TCodeModel>? tCodeModel;
  @JsonKey(name: 'T_VALUES')
  List<TValuesModel>? tValuesModel;

  CommonCodeResponseModel(this.esReturn, this.tCodeModel, this.tValuesModel);
  factory CommonCodeResponseModel.fromJson(Object? json) =>
      _$CommonCodeResponseModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$CommonCodeResponseModelToJson(this);
}
