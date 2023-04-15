import 'package:stylish_flutter_sam/api/dataSource/base_data_source.dart';
import 'package:stylish_flutter_sam/api/dataSource/remote_data_source.dart';
import 'package:stylish_flutter_sam/api/repo/base_repository.dart';
import 'package:stylish_flutter_sam/api/repo/data_provider.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

class StylishRepository extends BaseRepository {
  final DataProvider _dataProvider = DataProvider();
  final BaseDataSource _remoteDataSource = RemoteDataSource();

  @override
  Future<ProductContent?> getProductContent(String id) =>
      _dataProvider.getProductContent(id);

  @override
  Future<ProductsDatum> getAccessories() => _remoteDataSource.getAccessories();

  @override
  Future<ProductsDatum> getMenClothes() => _remoteDataSource.getMenClothes();

  @override
  Future<ProductsDatum> getWomenClothes() =>
      _remoteDataSource.getWomenClothes();
}
