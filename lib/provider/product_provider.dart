import 'package:database_app/database/controllers/producter_db_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = <Product>[];
  final ProductDbController _dbController = ProductDbController();

  Future<processResponse> create(Product product) async {
    int newRowId = await _dbController.create(product);
    if (newRowId != 0) {
      product.id = newRowId;
      products.add(product);
      notifyListeners();
    }
    return getResponse(newRowId != 0);
  }

  void read() async {
    products = await _dbController.read();
    notifyListeners();
  }

  Future<processResponse> update(Product product) async {
    bool update = await _dbController.update(product);
    if (update) {
      int index = products.indexWhere((element) => element.id == product.id);
      if (index != -1) {
        products[index] = product;
        notifyListeners();
      }
    }
    return getResponse(update);
  }

  Future<processResponse> delete(int index) async {
    bool delete = await _dbController.delete(products[index].id);
    if (delete) {
      products.remove(index);
      notifyListeners();
    }
    return getResponse(delete);
  }

  processResponse getResponse(bool success) {
    return processResponse(
      message:
          success ? 'Operation Completed successfully' : 'Operation failed',
      success: success,
    );
  }
}
