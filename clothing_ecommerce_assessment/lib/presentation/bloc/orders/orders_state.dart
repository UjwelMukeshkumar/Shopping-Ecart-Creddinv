part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  const OrdersState({this.orders = const [], this.loading = false, this.error});

  final List<PaymentReceipt> orders;
  final bool loading;
  final String? error;

  bool get isEmpty => orders.isEmpty;

  @override
  List<Object?> get props => [orders, loading, error];
}
