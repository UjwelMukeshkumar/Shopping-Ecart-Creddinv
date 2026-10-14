import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class ClearCart {
  const ClearCart(this.repository);

  final CartRepository repository;

  Future<List<CartItem>> call() => repository.clear();
}
