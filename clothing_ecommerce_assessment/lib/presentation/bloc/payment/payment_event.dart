part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class InitiatePayment extends PaymentEvent {
  const InitiatePayment(this.items);

  final List<CartItem> items;

  @override
  List<Object?> get props => [items];
}
