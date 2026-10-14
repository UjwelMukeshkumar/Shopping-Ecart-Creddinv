import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantity {
  const UpdateCartQuantity(this.repository);

  final CartRepository repository;

  Future<List<CartItem>> call(String id, int quantity) =>
      repository.updateQuantity(id, quantity);
}
