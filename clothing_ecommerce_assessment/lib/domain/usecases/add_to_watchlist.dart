import '../entities/product.dart';
import '../repositories/watchlist_repository.dart';

class AddToWatchlist {
  const AddToWatchlist(this.repository);
  final WatchlistRepository repository;
  Future<List<Product>> call(Product product) => repository.add(product);
}

/// Assessment terminology alias.
typedef AddToWatchlistUseCase = AddToWatchlist;
