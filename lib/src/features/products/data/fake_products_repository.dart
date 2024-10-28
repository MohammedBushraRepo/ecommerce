import 'dart:async';

import 'package:ecommerce/src/constants/test_products.dart';
import 'package:ecommerce/src/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  // //using private constructor to prevent creating instance
  // FakeProductsRepository._();
  // //use Singliton to created only instance to use it with out creating new instance every time
  // static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
    //return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  //debugPrint('Created Stream Provider');
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProductsList();
});

final productsListFutureProvider = FutureProvider<List<Product>>((ref) {
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.fetchProductsList();
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  //debugPrint('Created Product Provider with id : $id');

  // ref.onDispose(() => debugPrint(
  //     'dispose productProvider')); //to apply some thing while disposing

  // final link = ref.keepAlive();

  // Timer(const Duration(seconds: 10), () {
  //   link.close(); //dispose after agiven Delay
  // });

  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
