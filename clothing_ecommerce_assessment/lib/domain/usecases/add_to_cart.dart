import '../entities/cart_item.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  const AddToCart(this.repository);

  final CartRepository repository;

  Future<List<CartItem>> call(Product product) => repository.add(product);
}
