/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/model/commonCode/t_values_response_model.dart
 * Created Date: 2021-09-28 01:34:23
 * Last Modified: 2021-11-19 07:46:08
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:salesworxm/model/commonCode/t_values_model.dart';
part 't_values_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TValuesResponseModel {
  @JsonKey(name: 'T_VALUES')
  List<TValuesModel>? modelList;
  TValuesResponseModel(this.modelList);
  factory TValuesResponseModel.fromJson(Object? json) =>
      _$TValuesResponseModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$TValuesResponseModelToJson(this);
}
