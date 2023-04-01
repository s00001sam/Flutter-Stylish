import 'package:stylish_flutter_sam/data/HomeItem.dart';

abstract class BaseRepository {
  Future<HomeDatum> getHomeDatum();
}
