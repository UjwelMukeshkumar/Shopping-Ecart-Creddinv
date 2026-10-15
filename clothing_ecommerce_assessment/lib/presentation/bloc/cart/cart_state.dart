part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({this.items = const [], this.loading = false, this.error});

  final List<CartItem> items;
  final bool loading;
  final String? error;

  double get total => items.fold(0, (sum, item) => sum + item.lineTotal);
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items, loading, error];
}
