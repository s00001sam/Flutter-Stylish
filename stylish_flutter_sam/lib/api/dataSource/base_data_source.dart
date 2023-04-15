import 'package:stylish_flutter_sam/data/ProductDetailData.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

abstract class BaseDataSource {
  Future<ProductsDatum> getWomenClothes();

  Future<ProductsDatum> getMenClothes();

  Future<ProductsDatum> getAccessories();

  Future<ProductDetailData> getProductContent(int id);
}
