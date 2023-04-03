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

  List<int> colors() {
    var colors = stocks.map((stock) => stock.color);
    return colors.toList();
  }

  ProductStock? stockByColor(int colorsInt) {
    try {
      return stocks.firstWhere((stock) => stock.color == colorsInt);
    } catch (e) {
      return null;
    }
  }

  List<ProductSize> sizesByColor(int colorInt) {
    var stock = stockByColor(colorInt);
    return stock?.sizeCountMap.keys.toList() ?? [];
  }

  int totalCountByColorSize(
    int colorInt,
    ProductSize size,
  ) {
    var stock = stockByColor(colorInt);
    var sizeCountMap = stock?.sizeCountMap;
    var totalCount = sizeCountMap?[size];
    return totalCount ?? 0;
  }
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
