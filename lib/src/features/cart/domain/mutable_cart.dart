import 'package:ecommerce/src/features/cart/domain/cart.dart';
import 'package:ecommerce/src/features/cart/domain/item.dart';
import 'package:ecommerce/src/features/products/domain/product.dart';

/// 
extension MutableCart on Cart {
  Cart addItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    if (copy.containsKey(item.productId)) {
      copy[item.productId] = item.quantity + copy[item.productId]!;
    } else {
      copy[item.productId] = item.quantity;
    }
    return Cart(copy);
  }

  Cart addItems(List<Item> itemsToAdd) {
    final copy = Map<ProductID, int>.from(items);
    for (var item in itemsToAdd) {
      if (copy.containsKey(item.productId)) {
        copy[item.productId] = item.quantity + copy[item.productId]!;
      } else {
        copy[item.productId] = item.quantity;
      }
    }
    return Cart(copy);
  }

  Cart removeItemById(ProductID productId) {
    final copy = Map<ProductID, int>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }

  Cart updateItemIfExists(Item item) {
    if (items.containsKey(item.productId)) {
      final copy = Map<ProductID, int>.from(items);
      copy[item.productId] = item.quantity;
      return Cart(copy);
    } else {
      return this;
    }
  }

  Cart clear() {
    return const Cart();
  }
}
