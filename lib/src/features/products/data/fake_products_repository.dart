import 'package:ecommerce/src/constants/test_products.dart';
import 'package:ecommerce/src/features/products/domain/product.dart';

class FakeProductsRepository {
  //using private constructor to prevent creating instance
  FakeProductsRepository._();
  //use Singliton to created only instance to use it with out creating new instance every time
  static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}
