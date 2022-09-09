import 'package:database_app/database/controllers/producter_db_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/models/product.dart';
import 'package:get/get.dart';

class ProductGetxController extends GetxController {
  List<Product> products = <Product>[];
  final ProductDbController _dbController = ProductDbController();

  static ProductGetxController get to => Get.find<ProductGetxController>();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<processResponse> create(Product product) async {
    int newRowId = await _dbController.create(product);
    if (newRowId != 0) {
      product.id = newRowId;
      products.add(product);
      update();
    }
    return getResponse(newRowId != 0);
  }

  void read() async {
    products = await _dbController.read();
    update();
  }

  Future<processResponse> updateNote(Product product) async {
    bool update = await _dbController.update(product);
    if (update) {
      int index = products.indexWhere((element) => element.id == product.id);
      if (index != -1) {
        products[index] = product;
        update;
      }
    }
    return getResponse(update);
  }

  Future<processResponse> delete(int index) async {
    bool delete = await _dbController.delete(products[index].id);
    if (delete) {
      products.removeAt(index);
      update();
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
