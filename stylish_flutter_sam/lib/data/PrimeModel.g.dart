// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PrimeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimeModel _$PrimeModelFromJson(Map<String, dynamic> json) => PrimeModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      prime: json['prime'] as String?,
    );

Map<String, dynamic> _$PrimeModelToJson(PrimeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'prime': instance.prime,
    };
