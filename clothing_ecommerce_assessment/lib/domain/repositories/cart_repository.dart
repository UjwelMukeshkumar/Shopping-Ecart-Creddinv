import '../entities/cart_item.dart';
import '../entities/payment_receipt.dart';
import '../entities/product.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCart();
  Future<List<CartItem>> add(Product product);
  Future<List<CartItem>> remove(String productId);
  Future<List<CartItem>> updateQuantity(String productId, int quantity);
  Future<List<CartItem>> clear();
  Future<PaymentReceipt> pay(List<CartItem> items);
  Future<List<PaymentReceipt>> getOrders();
}

