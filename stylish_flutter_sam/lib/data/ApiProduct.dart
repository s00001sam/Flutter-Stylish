import 'package:json_annotation/json_annotation.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

import 'Colors.dart';
import 'Variants.dart';

part 'ApiProduct.g.dart';

@JsonSerializable()
class ApiProduct {
  int? id;
  String? category;
  String? title;
  String? description;
  int? price;
  String? texture;
  String? wash;
  String? place;
  String? note;
  String? story;
  List<Colors>? colors;
  List<String>? sizes;
  List<Variants>? variants;

  @JsonKey(name: 'main_image')
  String? mainImage;
  List<String>? images;

  factory ApiProduct.fromJson(Map<String, dynamic> json) =>
      _$ApiProductFromJson(json);

  Map<String, dynamic> toJson() => _$ApiProductToJson(this);

//<editor-fold desc="Data Methods">
  ApiProduct({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.mainImage,
    required this.images,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiProduct &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          category == other.category &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          texture == other.texture &&
          wash == other.wash &&
          place == other.place &&
          note == other.note &&
          story == other.story &&
          colors == other.colors &&
          sizes == other.sizes &&
          variants == other.variants &&
          mainImage == other.mainImage &&
          images == other.images);

  @override
  int get hashCode =>
      id.hashCode ^
      category.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      texture.hashCode ^
      wash.hashCode ^
      place.hashCode ^
      note.hashCode ^
      story.hashCode ^
      colors.hashCode ^
      sizes.hashCode ^
      variants.hashCode ^
      mainImage.hashCode ^
      images.hashCode;

  @override
  String toString() {
    return 'ApiProduct{ id: $id, category: $category, title: $title, description: $description, price: $price, texture: $texture, wash: $wash, place: $place, note: $note, story: $story, colors: $colors, sizes: $sizes, variants: $variants, mainImage: $mainImage, images: $images,}';
  }

  ApiProduct copyWith({
    int? id,
    String? category,
    String? title,
    String? description,
    int? price,
    String? texture,
    String? wash,
    String? place,
    String? note,
    String? story,
    List<Colors>? colors,
    List<String>? sizes,
    List<Variants>? variants,
    String? mainImage,
    List<String>? images,
  }) {
    return ApiProduct(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      texture: texture ?? this.texture,
      wash: wash ?? this.wash,
      place: place ?? this.place,
      note: note ?? this.note,
      story: story ?? this.story,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      variants: variants ?? this.variants,
      mainImage: mainImage ?? this.mainImage,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'category': this.category,
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'texture': this.texture,
      'wash': this.wash,
      'place': this.place,
      'note': this.note,
      'story': this.story,
      'colors': this.colors,
      'sizes': this.sizes,
      'variants': this.variants,
      'mainImage': this.mainImage,
      'images': this.images,
    };
  }

  factory ApiProduct.fromMap(Map<String, dynamic> map) {
    return ApiProduct(
      id: map['id'] as int,
      category: map['category'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      texture: map['texture'] as String,
      wash: map['wash'] as String,
      place: map['place'] as String,
      note: map['note'] as String,
      story: map['story'] as String,
      colors: map['colors'] as List<Colors>,
      sizes: map['sizes'] as List<String>,
      variants: map['variants'] as List<Variants>,
      mainImage: map['mainImage'] as String,
      images: map['images'] as List<String>,
    );
  }

  ProductContent toProductContent() {
    var colorCodes =
        colors?.map((color) => color.code).whereType<String>().toList() ?? [];
    List<ProductStock> stocks = [];
    colorCodes.forEach((colorCode) {
      var productStock = ProductStock(
        color: colorCode.toString(),
        sizeCountMap: {},
      );
      var variantsByColor =
          variants?.where((variant) => variant.colorCode == colorCode) ?? [];
      for (var variant in variantsByColor) {
        var size = variant.size?.toProductSize();
        var stock = variant.stock ?? 0;
        if (size == null || stock == 0) continue;
        productStock.sizeCountMap[size] = stock;
      }
      stocks.add(productStock);
    });

    return ProductContent(
      productId: id?.toString() ?? '',
      name: title ?? '',
      price: price ?? 0,
      stocks: stocks,
      description: story ?? '',
      mainImage: mainImage ?? '',
      images: images ?? [],
    );
  }
}
