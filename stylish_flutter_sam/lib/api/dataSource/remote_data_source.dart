import 'package:stylish_flutter_sam/api/api_service.dart';
import 'package:stylish_flutter_sam/api/dataSource/base_data_source.dart';
import 'package:stylish_flutter_sam/data/ApiProduct.dart';
import 'package:stylish_flutter_sam/data/ProductDetailData.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

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
}
