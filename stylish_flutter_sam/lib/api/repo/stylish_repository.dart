import 'package:stylish_flutter_sam/api/dataSource/base_data_source.dart';
import 'package:stylish_flutter_sam/api/dataSource/remote_data_source.dart';
import 'package:stylish_flutter_sam/api/repo/base_repository.dart';
import 'package:stylish_flutter_sam/data/ProductDetailData.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

class StylishRepository extends BaseRepository {
  final BaseDataSource _remoteDataSource = RemoteDataSource();

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
}
