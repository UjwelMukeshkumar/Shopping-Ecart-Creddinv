import 'dart:math';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/payment_receipt.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final Map<String, CartItem> _items = {};
  final List<PaymentReceipt> _orders = [];

  @override
  Future<List<CartItem>> getCart() async => List.unmodifiable(_items.values);

  @override
  Future<List<CartItem>> add(Product product) async {
    final old = _items[product.id];
    _items[product.id] = old == null
        ? CartItem(product: product, quantity: 1)
        : old.copyWith(quantity: old.quantity + 1);
    return getCart();
  }

  @override
  Future<List<CartItem>> remove(String productId) async {
    _items.remove(productId);
    return getCart();
  }

  @override
  Future<List<CartItem>> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      final item = _items[productId];
      if (item != null) {
        _items[productId] = item.copyWith(quantity: quantity);
      }
    }
    return getCart();
  }

  @override
  Future<List<CartItem>> clear() async {
    _items.clear();
    return getCart();
  }

  @override
  Future<PaymentReceipt> pay(List<CartItem> items) async {
    if (items.isEmpty) {
      throw Exception('Your cart is empty.');
    }
    await Future<void>.delayed(const Duration(seconds: 2));
    final total = items.fold<double>(0, (sum, item) => sum + item.lineTotal);
    final suffix = Random().nextInt(900000) + 100000;
    final receipt = PaymentReceipt(
      orderId: 'THR-$suffix',
      amount: total,
      items: List<CartItem>.from(items),
    );
    _orders.insert(0, receipt);
    return receipt;
  }

  @override
  Future<List<PaymentReceipt>> getOrders() async {
    return List<PaymentReceipt>.from(_orders);
  }
}
