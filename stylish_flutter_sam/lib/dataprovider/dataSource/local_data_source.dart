import 'package:sqflite/sqflite.dart';
import 'package:stylish_flutter_sam/data/DBProduct.dart';
import 'package:stylish_flutter_sam/data/ProductDetailData.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';
import 'package:stylish_flutter_sam/dataprovider/dataSource/base_data_source.dart';
import 'package:stylish_flutter_sam/dataprovider/local_db.dart';

class LocalDataSource extends BaseDataSource {
  static const String CART_TABLE = 'cart';
  final LocalDB _localDB = LocalDB();

  @override
  Future<ProductsDatum> getAccessories() {
    // TODO: implement getAccessories
    throw UnimplementedError();
  }

  @override
  Future<ProductsDatum> getMenClothes() {
    // TODO: implement getMenClothes
    throw UnimplementedError();
  }

  @override
  Future<ProductDetailData> getProductContent(int id) {
    // TODO: implement getProductContent
    throw UnimplementedError();
  }

  @override
  Future<ProductsDatum> getWomenClothes() {
    // TODO: implement getWomenClothes
    throw UnimplementedError();
  }

  @override
  Future insertCart(DBProduct product) async {
    final db = await _localDB.getDB();

    await db.insert(
      CART_TABLE,
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<DBProduct>> getProductsInCart() async {
    final db = await _localDB.getDB();

    final List<Map<String, dynamic>> maps = await db.query(CART_TABLE);

    return List.generate(maps.length, (i) {
      return DBProduct(
        id: maps[i]['id'],
        productId: maps[i]['productId'],
        imageUrl: maps[i]['imageUrl'],
        name: maps[i]['name'],
        colorCode: maps[i]['colorCode'],
        size: maps[i]['size'],
        count: maps[i]['count'],
        prize: maps[i]['prize'],
      );
    });
  }

  @override
  Future<void> deleteFromCart(int id) async {
    final db = await _localDB.getDB();

    await db.delete(
      CART_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
