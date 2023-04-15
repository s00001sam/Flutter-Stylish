// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiProduct _$ApiProductFromJson(Map<String, dynamic> json) => ApiProduct(
      id: json['id'] as int?,
      category: json['category'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] as int?,
      texture: json['texture'] as String?,
      wash: json['wash'] as String?,
      place: json['place'] as String?,
      note: json['note'] as String?,
      story: json['story'] as String?,
      colors: (json['colors'] as List<dynamic>?)
          ?.map((e) => Colors.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes:
          (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainImage: json['main_image'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ApiProductToJson(ApiProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'texture': instance.texture,
      'wash': instance.wash,
      'place': instance.place,
      'note': instance.note,
      'story': instance.story,
      'colors': instance.colors,
      'sizes': instance.sizes,
      'variants': instance.variants,
      'main_image': instance.mainImage,
      'images': instance.images,
    };
