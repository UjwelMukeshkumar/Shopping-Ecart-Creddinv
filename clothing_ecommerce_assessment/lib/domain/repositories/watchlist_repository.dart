import '../entities/product.dart';
abstract class WatchlistRepository {
  Future<List<Product>> getWatchlist();
  Future<List<Product>> add(Product product);
  Future<List<Product>> remove(String productId);
}
