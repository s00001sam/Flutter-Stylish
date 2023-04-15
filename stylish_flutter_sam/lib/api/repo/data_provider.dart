import 'package:stylish_flutter_sam/data/FakeDatum.dart';
import 'package:stylish_flutter_sam/data/HomeItem.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';


class DataProvider {
  Future<ProductContent?> getProductContent(String id) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    var content = allProductContents.firstWhere(
      (product) => product?.productId == id,
      orElse: () => null,
    );
    return content;
  }
}
