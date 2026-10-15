import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/payment_receipt.dart';
import '../../../domain/usecases/get_orders.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc(this.getOrders) : super(const OrdersState()) {
    on<LoadOrders>((event, emit) async {
      emit(OrdersState(orders: state.orders, loading: true));
      try {
        emit(OrdersState(orders: await getOrders()));
      } catch (_) {
        emit(const OrdersState(error: 'Could not load orders.'));
      }
    });
  }

  final GetOrders getOrders;
}
