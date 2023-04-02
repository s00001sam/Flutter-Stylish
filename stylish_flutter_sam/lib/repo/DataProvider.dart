import 'package:stylish_flutter_sam/data/HomeItem.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

import '../data/FakeDatum.dart';

class DataProvider {
  Future<HomeDatum> getHomeDatum() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return homeDatum;
  }

  Future<ProductContent?> getProductContent(String id) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    var content = allProductContents.firstWhere(
      (product) => product?.productId == id,
      orElse: () => null,
    );
    return content;
  }
}
