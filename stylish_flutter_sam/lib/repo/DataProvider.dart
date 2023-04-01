import 'package:stylish_flutter_sam/data/HomeItem.dart';

class DataProvider {
  Future<HomeDatum> getHomeDatum() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return homeDatum;
  }
}

var homeDatum = HomeDatum(
  bannerClothes: bannerClothes,
  categories: womenClothes + menClothes + accessories,
);

List<HomeProduct> bannerClothes = List<HomeProduct>.generate(
  10,
  (i) => HomeProduct(
    "01",
    "banner",
    500,
    "assets/images/ic_cloth_banner.jpg",
    CategoryType.other,
  ),
);

List<HomeProduct> womenClothes = List<HomeProduct>.generate(
  12,
  (i) => HomeProduct(
    "02",
    "women",
    200,
    "assets/images/ic_cloth_women.jpg",
    CategoryType.women,
  ),
);

List<HomeProduct> menClothes = List<HomeProduct>.generate(
  10,
  (i) => HomeProduct(
    "03",
    "men",
    100,
    "assets/images/ic_cloth_men.jpg",
    CategoryType.men,
  ),
);

final List<HomeProduct> accessories = List<HomeProduct>.generate(
  6,
  (i) => HomeProduct(
    "04",
    "accessory",
    1000,
    "assets/images/ic_accessory.jpg",
    CategoryType.accessory,
  ),
);
