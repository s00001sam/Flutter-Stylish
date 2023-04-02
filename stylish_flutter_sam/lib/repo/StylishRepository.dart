import 'package:stylish_flutter_sam/data/HomeItem.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';
import 'package:stylish_flutter_sam/repo/BaseRepository.dart';
import 'package:stylish_flutter_sam/repo/DataProvider.dart';

class StylishRepository extends BaseRepository {
  final DataProvider _dataProvider = DataProvider();

  @override
  Future<HomeDatum> getHomeDatum() => _dataProvider.getHomeDatum();

  @override
  Future<ProductContent?> getProductContent(String id) =>
      _dataProvider.getProductContent(id);
}
