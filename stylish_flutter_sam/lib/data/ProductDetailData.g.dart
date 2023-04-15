// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductDetailData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailData _$ProductDetailDataFromJson(Map<String, dynamic> json) =>
    ProductDetailData(
      apiProduct: ApiProduct.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailDataToJson(ProductDetailData instance) =>
    <String, dynamic>{
      'data': instance.apiProduct,
    };
