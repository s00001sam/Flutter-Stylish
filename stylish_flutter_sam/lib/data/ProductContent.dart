class ProductContent {
  late String productId;
  late String uid;
  late String name;
  late int price;
  late List<ProductStock> stocks;
  late String description;
  late List<String> images;

  ProductContent({
    required this.productId,
    required this.uid,
    required this.name,
    required this.price,
    required this.stocks,
    required this.description,
    required this.images,
  });
}

class ProductStock {
  late int color;
  late Map<ProductSize, int> sizeCountMap;

  ProductStock({required this.color, required this.sizeCountMap});
}

enum ProductSize {
  small,
  medium,
  large,
}
