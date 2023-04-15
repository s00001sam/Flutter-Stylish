class ProductContent {
  late String productId;
  late String name;
  late int price;
  late List<ProductStock> stocks;
  late String description;
  late String mainImage;
  late List<String> images;

  ProductContent({
    required this.productId,
    required this.name,
    required this.price,
    required this.stocks,
    required this.description,
    required this.mainImage,
    required this.images,
  });

  List<String> colors() {
    var colors = stocks.map((stock) => stock.color);
    return colors.toList();
  }

  ProductStock? stockByColor(String colorsInt) {
    try {
      return stocks.firstWhere((stock) => stock.color == colorsInt);
    } catch (e) {
      return null;
    }
  }

  List<ProductSize> sizesByColor(String colorInt) {
    var stock = stockByColor(colorInt);
    return stock?.sizeCountMap.keys.toList() ?? [];
  }

  int totalCountByColorSize(
    String colorInt,
    ProductSize size,
  ) {
    var stock = stockByColor(colorInt);
    var sizeCountMap = stock?.sizeCountMap;
    var totalCount = sizeCountMap?[size];
    return totalCount ?? 0;
  }
}

class ProductStock {
  late String color;
  late Map<ProductSize, int> sizeCountMap;

  ProductStock({required this.color, required this.sizeCountMap});
}

enum ProductSize {
  small,
  medium,
  large,
}

extension ColorExtension on String {
  ProductSize? toProductSize() {
    switch (this) {
      case 'S':
        return ProductSize.small;
      case 'M':
        return ProductSize.medium;
      case 'L':
        return ProductSize.large;
    }
    return null;
  }
}
