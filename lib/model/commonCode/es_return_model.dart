/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/kolonFile/salesworxm/lib/model/commonCode/es_return_model.dart
 * Created Date: 2022-01-15 18:52:33
 * Last Modified: 2022-01-15 18:52:56
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2022  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:json_annotation/json_annotation.dart';
part 'es_return_model.g.dart';

@JsonSerializable()
class EsReturnModel {
  @JsonKey(name: 'ARBGB')
  String? arbgb;
  @JsonKey(name: 'MSGNR')
  String? msgnr;
  @JsonKey(name: 'MTYPE')
  String? mtype;
  @JsonKey(name: 'MESSAGE')
  String? message;
  EsReturnModel(this.arbgb, this.msgnr, this.mtype, this.message);
  factory EsReturnModel.fromJson(Object? json) =>
      _$EsReturnModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$EsReturnModelToJson(this);
}
