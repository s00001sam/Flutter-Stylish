import 'package:stylish_flutter_sam/data/ProductContent.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

abstract class BaseRepository {
  Future<ProductContent?> getProductContent(String id);

  Future<ProductsDatum> getWomenClothes();

  Future<ProductsDatum> getMenClothes();

  Future<ProductsDatum> getAccessories();
}
