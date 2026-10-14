part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentProcessing extends PaymentState {
  const PaymentProcessing();
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess(this.receipt);

  final PaymentReceipt receipt;

  @override
  List<Object?> get props => [receipt];
}

class PaymentFailure extends PaymentState {
  const PaymentFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
