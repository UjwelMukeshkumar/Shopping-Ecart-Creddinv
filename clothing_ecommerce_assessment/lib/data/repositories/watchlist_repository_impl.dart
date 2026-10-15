import '../../domain/entities/product.dart';
import '../../domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final Map<String, Product> _saved = {};
  @override
  Future<List<Product>> getWatchlist() async =>
      List.unmodifiable(_saved.values);
  @override
  Future<List<Product>> add(Product product) async {
    _saved[product.id] = product;
    return getWatchlist();
  }

  @override
  Future<List<Product>> remove(String productId) async {
    _saved.remove(productId);
    return getWatchlist();
  }
}
