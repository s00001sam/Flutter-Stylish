import 'package:stylish_flutter_sam/data/HomeItem.dart';

import '../data/ProductContent.dart';

abstract class BaseRepository {
  Future<HomeDatum> getHomeDatum();

  Future<ProductContent?> getProductContent(String id);
}
