import 'package:json_annotation/json_annotation.dart';
import 'package:stylish_flutter_sam/data/HomeItem.dart';

import 'ApiProduct.dart';

part 'ProductsDatum.g.dart';

@JsonSerializable()
class ProductsDatum {
  @JsonKey(name: 'data')
  List<ApiProduct>? apiProducts;

  @JsonKey(name: 'next_paging')
  int? nextPaging;

  factory ProductsDatum.fromJson(Map<String, dynamic> json) =>
      _$ProductsDatumFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsDatumToJson(this);

  ProductsDatum({
    required this.apiProducts,
    required this.nextPaging,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsDatum &&
          runtimeType == other.runtimeType &&
          apiProducts == other.apiProducts &&
          nextPaging == other.nextPaging);

  @override
  int get hashCode => apiProducts.hashCode ^ nextPaging.hashCode;

  @override
  String toString() {
    return 'ProductsDatum{ apiProducts: $apiProducts, nextPaging: $nextPaging,}';
  }

  ProductsDatum copyWith({
    List<ApiProduct>? apiProducts,
    int? nextPaging,
  }) {
    return ProductsDatum(
      apiProducts: apiProducts ?? this.apiProducts,
      nextPaging: nextPaging ?? this.nextPaging,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'apiProducts': apiProducts,
      'nextPaging': nextPaging,
    };
  }

  factory ProductsDatum.fromMap(Map<String, dynamic> map) {
    return ProductsDatum(
      apiProducts: map['apiProducts'] as List<ApiProduct>,
      nextPaging: map['nextPaging'] as int,
    );
  }

  List<HomeProduct>? toHomeProducts(CategoryType type) {
    return apiProducts?.map(
      (product) => HomeProduct(
        id: product.id.toString(),
        name: product.title ?? "",
        price: product.price ?? 0,
        image: product.mainImage ?? "",
        type: type,
      ),
    ).toList();
  }
}
