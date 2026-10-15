import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class PaymentReceipt extends Equatable {
  const PaymentReceipt(
      {required this.orderId, required this.amount, required this.items});

  final String orderId;
  final double amount;

  final List<CartItem> items;

  @override
  List<Object?> get props => [orderId, amount, items];
}
