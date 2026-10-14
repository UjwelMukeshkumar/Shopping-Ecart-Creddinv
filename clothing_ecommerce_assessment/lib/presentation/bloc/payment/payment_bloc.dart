import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/payment_receipt.dart';
import '../../../domain/usecases/pay_for_cart.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(this.payForCart) : super(const PaymentInitial()) {
    on<InitiatePayment>((event, emit) async {
      emit(const PaymentProcessing());
      try {
        final receipt = await payForCart(event.items);
        emit(PaymentSuccess(receipt));
      } catch (e) {
        emit(PaymentFailure(e.toString().replaceFirst('Exception: ', '')));
      }
    });
  }
  final PayForCart payForCart;
}
