import 'package:stylish_flutter_sam/util/Util.dart';

abstract class HomeItem {
  late String name;
}

class HomeProduct implements HomeItem {
  late String id;
  @override
  late String name;
  late int price;
  late String image;
  late CategoryType type;

  HomeProduct(this.id, this.name, this.price, this.image, this.type);
}

class HomeCategoryTitle implements HomeItem {
  @override
  late String name;

  HomeCategoryTitle(this.name);
}

class HomeDatum {
  late List<HomeProduct> bannerClothes;
  late List<HomeProduct> categories;

  HomeDatum({required this.bannerClothes, required this.categories});

  Map<CategoryType, List<HomeProduct>> categoriesMap() {
    var products = categories;
    var map = products.groupBy((product) => product.type);
    return map;
  }
}

enum CategoryType {
  women,
  men,
  accessory,
  other,
}
