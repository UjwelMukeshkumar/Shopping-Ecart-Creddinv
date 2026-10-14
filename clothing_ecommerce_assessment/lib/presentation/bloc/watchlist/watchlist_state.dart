part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  const WatchlistState({
    this.products = const [],
    this.loading = false,
    this.error,
  });

  final List<Product> products;
  final bool loading;
  final String? error;

  bool contains(String id) => products.any((p) => p.id == id);

  @override
  List<Object?> get props => [products, loading, error];
}
