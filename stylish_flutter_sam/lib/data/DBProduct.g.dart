// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DBProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBProduct _$DBProductFromJson(Map<String, dynamic> json) => DBProduct(
      id: json['id'] as int,
      productId: json['productId'] as String,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      colorCode: json['colorCode'] as String,
      size: json['size'] as String,
      count: json['count'] as int,
      prize: json['prize'] as int,
    );

Map<String, dynamic> _$DBProductToJson(DBProduct instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'colorCode': instance.colorCode,
      'size': instance.size,
      'count': instance.count,
      'prize': instance.prize,
    };
