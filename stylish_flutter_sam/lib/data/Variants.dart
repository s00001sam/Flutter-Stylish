import 'package:json_annotation/json_annotation.dart';

part 'Variants.g.dart';

@JsonSerializable()
class Variants {
  @JsonKey(name: 'color_code')
  String? colorCode;
  String? size;
  int? stock;

  factory Variants.fromJson(Map<String, dynamic> json) =>
      _$VariantsFromJson(json);

  Map<String, dynamic> toJson() => _$VariantsToJson(this);

//<editor-fold desc="Data Methods">
  Variants({
    required this.colorCode,
    required this.size,
    required this.stock,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Variants &&
          runtimeType == other.runtimeType &&
          colorCode == other.colorCode &&
          size == other.size &&
          stock == other.stock);

  @override
  int get hashCode => colorCode.hashCode ^ size.hashCode ^ stock.hashCode;

  @override
  String toString() {
    return 'Variants{ colorCode: $colorCode, size: $size, stock: $stock,}';
  }

  Variants copyWith({
    String? colorCode,
    String? size,
    int? stock,
  }) {
    return Variants(
      colorCode: colorCode ?? this.colorCode,
      size: size ?? this.size,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'colorCode': this.colorCode,
      'size': this.size,
      'stock': this.stock,
    };
  }

  factory Variants.fromMap(Map<String, dynamic> map) {
    return Variants(
      colorCode: map['colorCode'] as String,
      size: map['size'] as String,
      stock: map['stock'] as int,
    );
  }

//</editor-fold>
}
