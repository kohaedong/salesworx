/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesportal/lib/model/commonCode/is_login_model.dart
 * Created Date: 2022-01-05 14:38:48
 * Last Modified: 2022-01-05 14:49:26
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2022  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:json_annotation/json_annotation.dart';
part 'is_login_model.g.dart';

@JsonSerializable()
class IsLoginModel {
  @JsonKey(name: 'LOGID')
  String? logid;
  @JsonKey(name: 'ENAME')
  String? ename;
  @JsonKey(name: 'BUKRS')
  String? bukrs;
  @JsonKey(name: 'VKORG')
  String? vkorg;
  @JsonKey(name: 'DPTCD')
  String? dptcd;
  @JsonKey(name: 'DPTNM')
  String? dptnm;
  @JsonKey(name: 'ORGHK')
  String? orghk;
  @JsonKey(name: 'SALEM')
  String? salem;
  @JsonKey(name: 'SYSIP')
  String? sysip;
  @JsonKey(name: 'SPRAS')
  String? spras;
  @JsonKey(name: 'XTM')
  String? xtm;
  @JsonKey(name: 'VKGRP')
  String? vkgrp;
  IsLoginModel(
      this.bukrs,
      this.dptcd,
      this.dptnm,
      this.ename,
      this.logid,
      this.orghk,
      this.salem,
      this.spras,
      this.sysip,
      this.vkgrp,
      this.vkorg,
      this.xtm);
  factory IsLoginModel.fromJson(Object? json) =>
      _$IsLoginModelFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$IsLoginModelToJson(this);
}
