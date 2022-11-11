/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/model/rfc/et_dd07v_custmer_category_model.dart
 * Created Date: 2021-09-29 11:47:48
 * Last Modified: 2021-10-02 23:23:28
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'et_dd07v_customer_category_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 3)
class EtDd07vCustomerModel {
  @HiveField(1)
  @JsonKey(name: 'DOMNAME')
  String? domname;
  @HiveField(2)
  @JsonKey(name: 'VALPOS')
  String? valpos;
  @HiveField(3)
  @JsonKey(name: 'DDLANGUAGE')
  String? dolanguage;
  @HiveField(4)
  @JsonKey(name: 'DOMVALUE_L')
  String? domvalueL;
  @HiveField(5)
  @JsonKey(name: 'DOMVALUE_H')
  String? domvalueH;
  @HiveField(6)
  @JsonKey(name: 'DDTEXT')
  String? ddtext;
  @HiveField(7)
  @JsonKey(name: 'DOMVAL_LD')
  String? domvalLD;
  @HiveField(8)
  @JsonKey(name: 'DOMVAL_HD')
  String? domvalHD;
  @HiveField(9)
  @JsonKey(name: 'APPVAL')
  String? appval;

  EtDd07vCustomerModel(
      this.appval,
      this.ddtext,
      this.dolanguage,
      this.domname,
      this.domvalHD,
      this.domvalLD,
      this.domvalueH,
      this.domvalueL,
      this.valpos);
  factory EtDd07vCustomerModel.fromJson(Object? json) =>
      _$EtDd07vCustomerModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$EtDd07vCustomerModelToJson(this);
}
