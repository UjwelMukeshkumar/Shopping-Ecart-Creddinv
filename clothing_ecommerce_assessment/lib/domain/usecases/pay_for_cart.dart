import '../entities/cart_item.dart';
import '../entities/payment_receipt.dart';
import '../repositories/cart_repository.dart';

class PayForCart {
  const PayForCart(this.repository);

  final CartRepository repository;

  Future<PaymentReceipt> call(List<CartItem> items) => repository.pay(items);
}
