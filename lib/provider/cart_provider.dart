import 'package:database_app/database/controllers/cart_db_controller.dart';
import 'package:database_app/models/cart.dart';
import 'package:database_app/models/process_response.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> cartsItems = <Cart>[];

  final CartDbController _dbController = CartDbController();
  double total = 0;
  double quantity = 0;

  Future<processResponse> create(Cart cart) async {
    int index =
        cartsItems.indexWhere((element) => element.productId == cart.productId);

    if (index == -1) {
      int newRowId = await _dbController.create(cart);
      if (newRowId != 0) {
        total += cart.total;
        quantity += 1;
        cart.id = newRowId;
        cartsItems.add(cart);
        notifyListeners();
      }
      return getResponse(newRowId != 0);
    } else {
      int newCount = cartsItems[index].count + 1;
      return changeQuantity(index, newCount);
    }
  }

  void read() async {
    cartsItems = await _dbController.read();
    for (Cart cart in cartsItems) {
      total += cart.total;
      quantity += cart.count;
    }
    notifyListeners();
  }

  Future<processResponse> changeQuantity(int index, int count) async {
    bool isDelete = count == 0;
    Cart cart = cartsItems[index];
    bool result = isDelete
        ? await _dbController.delete(cart.id)
        : await _dbController.update(cart);
    if (result) {
      if (isDelete) {
        total -= cart.total;
        quantity -= 1;
        cartsItems.removeAt(index);
      } else {
        cart.count = count;
        cart.total = cart.price * cart.count;
        total += cart.total;
        quantity += 1;
        cartsItems[index] = cart;
      }
      notifyListeners();
    }
    return getResponse(result);
  }

  Future<processResponse> clear() async {
    bool cleared = await _dbController.clear();
    if (cleared) {
      total = 0;
      quantity = 0;
      cartsItems.clear();
      notifyListeners();
    }
    return getResponse(cleared);
  }

  processResponse getResponse(bool success) {
    return processResponse(
      message:
          success ? 'Operation Completed successfully' : 'Operation failed',
      success: success,
    );
  }
}
