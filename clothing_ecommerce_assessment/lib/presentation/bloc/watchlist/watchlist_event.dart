part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {
  const LoadWatchlist();
}

class AddWatchlistProduct extends WatchlistEvent {
  const AddWatchlistProduct(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}

class RemoveWatchlistProduct extends WatchlistEvent {
  const RemoveWatchlistProduct(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}
