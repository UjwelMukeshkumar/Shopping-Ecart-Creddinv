import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCart {
  const RemoveFromCart(this.repository);
  final CartRepository repository;
  Future<List<CartItem>> call(String productId) => repository.remove(productId);
}

/// Assessment terminology alias.
typedef RemoveFromCartUseCase = RemoveFromCart;
