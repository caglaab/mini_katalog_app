import 'package:flutter/foundation.dart';

import '../models/product.dart';

/// Sepetteki tek bir satır: ürün + adet.
class CartItem {
  final Product product;
  final int quantity;

  const CartItem(this.product, {this.quantity = 1});
}

/// Basit sepet yönetimi (ekstra paket yok).
/// ValueNotifier sayesinde sepet değişince dinleyen ekranlar kendini yeniler.
class CartState {
  CartState._();

  static final CartState instance = CartState._();

  final ValueNotifier<List<CartItem>> items = ValueNotifier<List<CartItem>>(<CartItem>[]);

  int get totalCount =>
      items.value.fold<int>(0, (sum, item) => sum + item.quantity);

  double get totalPrice => items.value.fold<double>(
        0,
        (sum, item) => sum + item.product.priceValue * item.quantity,
      );

  /// Sepete 1 adet ekler.
  void add(Product product) {
    final list = List<CartItem>.from(items.value);
    final index = list.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      list[index] = CartItem(product, quantity: list[index].quantity + 1);
    } else {
      list.add(CartItem(product));
    }
    items.value = list;
  }

  /// Sepetten 1 adet çıkarır. Adet 0 olursa ürün listeden silinir.
  void remove(Product product) {
    final list = List<CartItem>.from(items.value);
    final index = list.indexWhere((item) => item.product.id == product.id);
    if (index < 0) return;

    final current = list[index];
    if (current.quantity > 1) {
      list[index] = CartItem(product, quantity: current.quantity - 1);
    } else {
      list.removeAt(index);
    }
    items.value = list;
  }

  /// Sepeti tamamen boşaltır.
  void clear() {
    items.value = <CartItem>[];
  }
}
