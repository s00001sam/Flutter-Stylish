
import 'package:json_annotation/json_annotation.dart';
import 'package:stylish_flutter_sam/data/ApiProduct.dart';

part 'ProductDetailData.g.dart';

@JsonSerializable()
class ProductDetailData {
  @JsonKey(name: 'data')
  ApiProduct apiProduct;

  factory ProductDetailData.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailDataToJson(this);

  ProductDetailData({
    required this.apiProduct,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductDetailData &&
          runtimeType == other.runtimeType &&
          apiProduct == other.apiProduct);

  @override
  int get hashCode => apiProduct.hashCode;

  @override
  String toString() {
    return 'ProductDetailData{' + ' apiProduct: $apiProduct,' + '}';
  }

  ProductDetailData copyWith({
    ApiProduct? apiProduct,
  }) {
    return ProductDetailData(
      apiProduct: apiProduct ?? this.apiProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'apiProduct': this.apiProduct,
    };
  }

  factory ProductDetailData.fromMap(Map<String, dynamic> map) {
    return ProductDetailData(
      apiProduct: map['apiProduct'] as ApiProduct,
    );
  }

//</editor-fold>
}