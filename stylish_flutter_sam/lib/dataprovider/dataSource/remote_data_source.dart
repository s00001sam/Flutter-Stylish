import 'package:stylish_flutter_sam/data/DBProduct.dart';
import 'package:stylish_flutter_sam/data/ProductDetailData.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';
import 'package:stylish_flutter_sam/dataprovider/api_service.dart';
import 'package:stylish_flutter_sam/dataprovider/dataSource/base_data_source.dart';

class RemoteDataSource extends BaseDataSource {
  final ApiService _apiService = ApiService();

  @override
  Future<ProductsDatum> getWomenClothes() async {
    var response = await _apiService.getWomenClothes();
    return ProductsDatum.fromJson(response.data);
  }

  @override
  Future<ProductsDatum> getMenClothes() async {
    var response = await _apiService.getMenClothes();

    return ProductsDatum.fromJson(response.data);
  }

  @override
  Future<ProductsDatum> getAccessories() async {
    var response = await _apiService.getAccessories();

    return ProductsDatum.fromJson(response.data);
  }

  @override
  Future<ProductDetailData> getProductContent(int id) async {
    var response = await _apiService.getProductContent(id);

    return ProductDetailData.fromJson(response.data);
  }

  @override
  Future<void> deleteFromCart(int id) {
    // TODO: implement deleteFromCart
    throw UnimplementedError();
  }

  @override
  Future insertCart(DBProduct product) {
    // TODO: implement insertCart
    throw UnimplementedError();
  }

  @override
  Future<List<DBProduct>> getProductsInCart() {
    // TODO: implement queryCart
    throw UnimplementedError();
  }
}
