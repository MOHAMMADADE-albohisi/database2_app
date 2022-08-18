class Cart {
  late int id;
  late double total;
  late double price;
  late int count;
  late int userId;
  late int productId;

  static const String tableName = 'cart';

  Cart();

  Cart.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    total = rowMap['total'];
    count = rowMap['count'];
    price = rowMap['price'];
    userId = rowMap['user_id'];
    productId = rowMap['product_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['total'] = total;
    map['count'] = count;
    map['price'] = price;
    map['user_id'] = userId;
    map['product_id'] = productId;
    return map;
  }
}
