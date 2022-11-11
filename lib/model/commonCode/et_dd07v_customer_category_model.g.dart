// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'et_dd07v_customer_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EtDd07vCustomerModelAdapter extends TypeAdapter<EtDd07vCustomerModel> {
  @override
  final int typeId = 3;

  @override
  EtDd07vCustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EtDd07vCustomerModel(
      fields[9] as String?,
      fields[6] as String?,
      fields[3] as String?,
      fields[1] as String?,
      fields[8] as String?,
      fields[7] as String?,
      fields[5] as String?,
      fields[4] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EtDd07vCustomerModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.domname)
      ..writeByte(2)
      ..write(obj.valpos)
      ..writeByte(3)
      ..write(obj.dolanguage)
      ..writeByte(4)
      ..write(obj.domvalueL)
      ..writeByte(5)
      ..write(obj.domvalueH)
      ..writeByte(6)
      ..write(obj.ddtext)
      ..writeByte(7)
      ..write(obj.domvalLD)
      ..writeByte(8)
      ..write(obj.domvalHD)
      ..writeByte(9)
      ..write(obj.appval);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EtDd07vCustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EtDd07vCustomerModel _$EtDd07vCustomerModelFromJson(
        Map<String, dynamic> json) =>
    EtDd07vCustomerModel(
      json['APPVAL'] as String?,
      json['DDTEXT'] as String?,
      json['DDLANGUAGE'] as String?,
      json['DOMNAME'] as String?,
      json['DOMVAL_HD'] as String?,
      json['DOMVAL_LD'] as String?,
      json['DOMVALUE_H'] as String?,
      json['DOMVALUE_L'] as String?,
      json['VALPOS'] as String?,
    );

Map<String, dynamic> _$EtDd07vCustomerModelToJson(
        EtDd07vCustomerModel instance) =>
    <String, dynamic>{
      'DOMNAME': instance.domname,
      'VALPOS': instance.valpos,
      'DDLANGUAGE': instance.dolanguage,
      'DOMVALUE_L': instance.domvalueL,
      'DOMVALUE_H': instance.domvalueH,
      'DDTEXT': instance.ddtext,
      'DOMVAL_LD': instance.domvalLD,
      'DOMVAL_HD': instance.domvalHD,
      'APPVAL': instance.appval,
    };
