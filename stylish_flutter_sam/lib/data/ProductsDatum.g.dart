// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductsDatum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsDatum _$ProductsDatumFromJson(Map<String, dynamic> json) =>
    ProductsDatum(
      apiProducts: (json['data'] as List<dynamic>?)
          ?.map((e) => ApiProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPaging: json['next_paging'] as int?,
    );

Map<String, dynamic> _$ProductsDatumToJson(ProductsDatum instance) =>
    <String, dynamic>{
      'data': instance.apiProducts,
      'next_paging': instance.nextPaging,
    };
