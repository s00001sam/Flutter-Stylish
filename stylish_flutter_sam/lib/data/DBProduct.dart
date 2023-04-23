import 'package:json_annotation/json_annotation.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

part 'DBProduct.g.dart';

@JsonSerializable()
class DBProduct {
  final int? id;
  final String productId;
  final String imageUrl;
  final String name;
  final String colorCode;
  final String size;
  final int count;
  final int prize;

  factory DBProduct.fromJson(Map<String, dynamic> json) => _$DBProductFromJson(json);

  Map<String, dynamic> toJson() => _$DBProductToJson(this);

  int getTotalPrize() {
    return prize * count;
  }

//<editor-fold desc="Data Methods">
  const DBProduct({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.colorCode,
    required this.size,
    required this.count,
    required this.prize,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBProduct &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          productId == other.productId &&
          imageUrl == other.imageUrl &&
          name == other.name &&
          colorCode == other.colorCode &&
          size == other.size &&
          count == other.count &&
          prize == other.prize);

  @override
  int get hashCode =>
      id.hashCode ^
      productId.hashCode ^
      imageUrl.hashCode ^
      name.hashCode ^
      colorCode.hashCode ^
      size.hashCode ^
      count.hashCode ^
      prize.hashCode;

  @override
  String toString() {
    return 'DBProduct{' +
        ' id: $id,' +
        ' productId: $productId,' +
        ' imageUrl: $imageUrl,' +
        ' name: $name,' +
        ' colorCode: $colorCode,' +
        ' size: $size,' +
        ' count: $count,' +
        ' prize: $prize,' +
        '}';
  }

  DBProduct copyWith({
    int? id,
    String? productId,
    String? imageUrl,
    String? name,
    String? colorCode,
    String? size,
    int? count,
    int? prize,
  }) {
    return DBProduct(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      colorCode: colorCode ?? this.colorCode,
      size: size ?? this.size,
      count: count ?? this.count,
      prize: prize ?? this.prize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productId': this.productId,
      'imageUrl': this.imageUrl,
      'name': this.name,
      'colorCode': this.colorCode,
      'size': this.size,
      'count': this.count,
      'prize': this.prize,
    };
  }

  factory DBProduct.fromMap(Map<String, dynamic> map) {
    return DBProduct(
      id: map['id'] as int,
      productId: map['productId'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      colorCode: map['colorCode'] as String,
      size: map['size'] as String,
      count: map['count'] as int,
      prize: map['prize'] as int,
    );
  }

//</editor-fold>
}
