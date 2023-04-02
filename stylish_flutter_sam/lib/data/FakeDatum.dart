import 'package:stylish_flutter_sam/data/ProductContent.dart';

import 'HomeItem.dart';

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

List<ProductContent?> allProductContents = [
  bannerProductContent,
];

var bannerProductContent = ProductContent(
  productId: "01",
  uid: "2023040201",
  name: "Stylish 清倉特賣球衣",
  price: 500,
  stocks: [
    ProductStock(
      color: 0xff000000,
      sizeCountMap: {
        ProductSize.small: 3,
        ProductSize.large: 10,
      },
    ),
    ProductStock(
      color: 0xffffffff,
      sizeCountMap: {
        ProductSize.small: 1,
        ProductSize.medium: 5,
        ProductSize.large: 6,
      },
    ),
    ProductStock(
      color: 0xffea0707,
      sizeCountMap: {
        ProductSize.small: 8,
      },
    ),
  ],
  description:
      "林盡水源，便得一山。山有小口，彷彿若有光，便舍船，從口入。初極狹，纔通人；復行數十步，豁然開朗。土地平曠，屋舍儼然。有良田、美池、桑、竹之屬，阡陌交通，雞犬相聞。其中往來種作，男女衣著，悉如外人；黃髮垂髫，並佁然自樂。見漁人，乃大驚，問所從來；具答之。便要還家，設酒、殺雞、作食。村中聞有此人，咸來問訊。自云：「先世避秦時亂，率妻子邑人來此絕境，不復出焉；遂與外人間隔。」問「今是何世？」乃不知有漢，無論魏、晉！此人一一為具言所聞，皆歎惋。餘人各復延至其家，皆出酒食。停數日，辭去。此中人語云：「不足為外人道也。」",
  images: [
    "assets/images/ic_cloth_banner.jpg",
    "assets/images/ic_cloth_banner.jpg",
    "assets/images/ic_cloth_banner.jpg",
    "assets/images/ic_cloth_banner.jpg",
    "assets/images/ic_cloth_banner.jpg",
  ],
);
