import 'package:stylish_flutter_sam/data/DBProduct.dart';
import 'package:stylish_flutter_sam/data/ProductDetailData.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';
import 'package:stylish_flutter_sam/dataprovider/dataSource/base_data_source.dart';
import 'package:stylish_flutter_sam/dataprovider/dataSource/local_data_source.dart';
import 'package:stylish_flutter_sam/dataprovider/dataSource/remote_data_source.dart';
import 'package:stylish_flutter_sam/dataprovider/repo/base_repository.dart';

class StylishRepository extends BaseRepository {
  final BaseDataSource _remoteDataSource = RemoteDataSource();
  final BaseDataSource _localDataSource = LocalDataSource();

  @override
  Future<ProductsDatum> getAccessories() => _remoteDataSource.getAccessories();

  @override
  Future<ProductsDatum> getMenClothes() => _remoteDataSource.getMenClothes();

  @override
  Future<ProductsDatum> getWomenClothes() =>
      _remoteDataSource.getWomenClothes();

  @override
  Future<ProductDetailData> getProductContent(int id) =>
      _remoteDataSource.getProductContent(id);

  @override
  Future insertCart(DBProduct product) => _localDataSource.insertCart(product);

  @override
  Future<List<DBProduct>> getProductsInCart() =>
      _localDataSource.getProductsInCart();

  @override
  Future<void> deleteFromCart(int id) => _localDataSource.deleteFromCart(id);
}
