// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsLoginModel _$IsLoginModelFromJson(Map<String, dynamic> json) => IsLoginModel(
      json['BUKRS'] as String?,
      json['DPTCD'] as String?,
      json['DPTNM'] as String?,
      json['ENAME'] as String?,
      json['LOGID'] as String?,
      json['ORGHK'] as String?,
      json['SALEM'] as String?,
      json['SPRAS'] as String?,
      json['SYSIP'] as String?,
      json['VKGRP'] as String?,
      json['VKORG'] as String?,
      json['XTM'] as String?,
    );

Map<String, dynamic> _$IsLoginModelToJson(IsLoginModel instance) =>
    <String, dynamic>{
      'LOGID': instance.logid,
      'ENAME': instance.ename,
      'BUKRS': instance.bukrs,
      'VKORG': instance.vkorg,
      'DPTCD': instance.dptcd,
      'DPTNM': instance.dptnm,
      'ORGHK': instance.orghk,
      'SALEM': instance.salem,
      'SYSIP': instance.sysip,
      'SPRAS': instance.spras,
      'XTM': instance.xtm,
      'VKGRP': instance.vkgrp,
    };
