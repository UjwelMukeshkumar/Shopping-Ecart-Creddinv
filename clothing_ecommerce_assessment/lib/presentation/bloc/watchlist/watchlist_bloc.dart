import 'package:equatable/equatable.dart'; import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart'; import '../../../domain/usecases/get_watchlist.dart'; import '../../../domain/usecases/add_to_watchlist.dart'; import '../../../domain/usecases/remove_from_watchlist.dart';
abstract class WatchlistEvent extends Equatable { const WatchlistEvent(); @override List<Object?> get props => []; }
class LoadWatchlist extends WatchlistEvent { const LoadWatchlist(); }
class AddWatchlistProduct extends WatchlistEvent { const AddWatchlistProduct(this.product); final Product product; @override List<Object?> get props => [product]; }
class RemoveWatchlistProduct extends WatchlistEvent { const RemoveWatchlistProduct(this.productId); final String productId; @override List<Object?> get props => [productId]; }
class WatchlistState extends Equatable { const WatchlistState({this.products = const [], this.loading = false, this.error}); final List<Product> products; final bool loading; final String? error; bool contains(String id) => products.any((p) => p.id == id); @override List<Object?> get props => [products, loading, error]; }
class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc({required this.getWatchlist, required this.addToWatchlist, required this.removeFromWatchlist}) : super(const WatchlistState()) {
    on<LoadWatchlist>((e, emit) async { emit(WatchlistState(products: state.products, loading: true)); try { emit(WatchlistState(products: await getWatchlist())); } catch (_) { emit(const WatchlistState(error: 'Could not load watchlist.')); } });
    on<AddWatchlistProduct>((e, emit) async { try { emit(WatchlistState(products: await addToWatchlist(e.product))); } catch (_) { emit(WatchlistState(products: state.products, error: 'Could not save favourite.')); } });
    on<RemoveWatchlistProduct>((e, emit) async { try { emit(WatchlistState(products: await removeFromWatchlist(e.productId))); } catch (_) { emit(WatchlistState(products: state.products, error: 'Could not remove favourite.')); } });
  }
  final GetWatchlist getWatchlist; final AddToWatchlist addToWatchlist; final RemoveFromWatchlist removeFromWatchlist;
}
