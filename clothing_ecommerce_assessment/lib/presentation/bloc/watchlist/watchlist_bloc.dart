import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_watchlist.dart';
import '../../../domain/usecases/add_to_watchlist.dart';
import '../../../domain/usecases/remove_from_watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc({
    required this.getWatchlist,
    required this.addToWatchlist,
    required this.removeFromWatchlist,
  }) : super(const WatchlistState()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<AddWatchlistProduct>(_onAddWatchlistProduct);
    on<RemoveWatchlistProduct>(_onRemoveWatchlistProduct);
  }

  final GetWatchlist getWatchlist;
  final AddToWatchlist addToWatchlist;
  final RemoveFromWatchlist removeFromWatchlist;

  Future<void> _onLoadWatchlist(
      LoadWatchlist event, Emitter<WatchlistState> emit) async {
    emit(WatchlistState(products: state.products, loading: true));
    try {
      emit(WatchlistState(products: await getWatchlist()));
    } catch (_) {
      emit(const WatchlistState(error: 'Could not load watchlist.'));
    }
  }

  Future<void> _onAddWatchlistProduct(
      AddWatchlistProduct event, Emitter<WatchlistState> emit) async {
    try {
      emit(WatchlistState(products: await addToWatchlist(event.product)));
    } catch (_) {
      emit(WatchlistState(
          products: state.products, error: 'Could not save favourite.'));
    }
  }

  Future<void> _onRemoveWatchlistProduct(
      RemoveWatchlistProduct event, Emitter<WatchlistState> emit) async {
    try {
      emit(WatchlistState(products: await removeFromWatchlist(event.productId)));
    } catch (_) {
      emit(WatchlistState(
          products: state.products, error: 'Could not remove favourite.'));
    }
  }
}
