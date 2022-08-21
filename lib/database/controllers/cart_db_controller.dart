import 'package:database_app/database/db_oprations.dart';
import 'package:database_app/models/cart.dart';

class CartDbController extends DbOperations<Cart> {
  //CRUD
//Create, Read, Update, Delete

  @override
  Future<int> create(Cart model) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Cart>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Cart?> show(int id) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cart model) {
    // TODO: implement update
    throw UnimplementedError();
  }


}
