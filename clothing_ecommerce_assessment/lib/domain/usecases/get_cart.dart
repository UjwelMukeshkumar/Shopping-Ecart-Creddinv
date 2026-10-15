import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCart {
  const GetCart(this.repository);

  final CartRepository repository;

  Future<List<CartItem>> call() => repository.getCart();
}
