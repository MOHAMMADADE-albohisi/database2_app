import 'package:database_app/database/db_oprations.dart';
import 'package:database_app/models/cart.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';

class CartDbController extends DbOperations<Cart> {
  //CRUD
//Create, Read, Update, Delete

  int userId = SharedPrefController().getValueFor<int>(savedata.id.name)!;

  @override
  Future<int> create(Cart model) async {
    // User add new Item for the first time to the cart
    return await database.insert(Cart.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRows = await database.delete(
      Cart.tableName,
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );
    return countOfDeleteRows == 1;
  }

  @override
  Future<List<Cart>> read() async {

    List<Map<String, dynamic>> rowsMap = await database.rawQuery(
        'SELECT cart.id, cart.product_id, cart.count, cart.total, cart.price, cart.user_id, products.name '
        'FROM cart JOIN products ON cart.product_id  = products.id '
        'WHERE cart.user_id = ?',[userId]);
    return rowsMap.map((rowMap) => Cart.fromMap(rowMap)).toList();
  }

  @override
  Future<Cart?> show(int id) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cart model) async {
    int countOfUpdatedRows = await database.update(
      Cart.tableName,
      model.toMap(),
      where: 'id= ? AND user_id = ?',
      whereArgs: [model.id, userId],
    );
    return countOfUpdatedRows == 1;
  }

  //دالة الحدف الكامل للسلة وهي دالة اختيارية
  @override
  Future<bool> clear() async {
    int countOfUpdatedRows = await database.delete(
      Cart.tableName,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return countOfUpdatedRows > 0;
  }
}
