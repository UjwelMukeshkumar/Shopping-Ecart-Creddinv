import '../entities/product.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlist {
  const GetWatchlist(this.repository);
  final WatchlistRepository repository;
  Future<List<Product>> call() => repository.getWatchlist();
}

/// Assessment terminology alias.
typedef GetWatchlistUseCase = GetWatchlist;
