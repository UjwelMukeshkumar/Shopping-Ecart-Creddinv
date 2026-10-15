import '../entities/payment_receipt.dart';
import '../repositories/cart_repository.dart';

class GetOrders {
  const GetOrders(this.repository);

  final CartRepository repository;

  Future<List<PaymentReceipt>> call() => repository.getOrders();
}
