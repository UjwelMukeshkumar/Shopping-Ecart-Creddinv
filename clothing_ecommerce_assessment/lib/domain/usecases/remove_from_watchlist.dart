import '../entities/product.dart';
import '../repositories/watchlist_repository.dart';

class RemoveFromWatchlist {
  const RemoveFromWatchlist(this.repository);

  final WatchlistRepository repository;

  Future<List<Product>> call(String productId) => repository.remove(productId);
}
