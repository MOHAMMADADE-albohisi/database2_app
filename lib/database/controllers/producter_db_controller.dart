import 'package:database_app/database/db_oprations.dart';
import 'package:database_app/models/product.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';

class ProductDbController extends DbOperations<Product> {
  @override
  Future<int> create(Product model) async {
    // int newRowId = await database.rawInsert(
    //   'INSERT INTO products( name, info,price, quantity, user_id) VALUES(?, ?, ?, ?, ?)',
    //   [model.name, model.info, model.price, model.quantity, model.userId],
    // );

    return await database.insert(Product.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    //الطريقة الاولى
    // int countOfDeleteRows =
    //     await database.rawDelete('DELETE FROM products WHERE id=?', [id]);
    // return countOfDeleteRows != 0;
//***********************************************
    //الطريقة الثانية
    int countOfDeleteRows = await database
        .delete(Product.tableName, where: 'id= ?', whereArgs: [id]);
    return countOfDeleteRows == 1;
  }

  @override
  Future<List<Product>> read() async {
    int useId = SharedPrefController().getValueFor<int>(savedata.id.name)!;
    List<Map<String, dynamic>> rowsMap = await database
        .query(Product.tableName, where: 'user_id = ?', whereArgs: [useId]);
    return rowsMap.map((rowsMap) => Product.fromMap(rowsMap)).toList();
  }

  @override
  Future<Product?> show(int id) async {
    //الطريقة الاولى
    // List<Map<String, dynamic>> rowsMap =
    //     await database.rawQuery('SELECT  * FROM products WHERE id = ?', [id]);
    // if (rowsMap.isNotEmpty) {
    //   return Product.fromMap(rowsMap.first);
    // }
    // return null;
//*********************************
    //الطريقة الثانية
    List<Map<String, dynamic>> rowsMap = await database
        .query(Product.tableName, where: 'id = ?', whereArgs: [id]);
    return rowsMap.isNotEmpty ? Product.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(Product model) async {
    // int countOfUpdateRows = await database.rawUpdate(
    //     'UPDATE products SET name=?, info =?, price =?,quantity =?,WHERE id =? AND  user_id =?',
    //     [model.name, model.info, model.price, model.quantity, model.id, model.userId
    //     ]);
    // return countOfUpdateRows == 1;

    //****************************************************
    int countOfUpdateRows = await database.update(
      Product.tableName,
      model.toMap(),
      where: 'id = ? AND user_id = ?',
      whereArgs: [model.id, model.userId],
    );
    return countOfUpdateRows == 1;
  }
}
