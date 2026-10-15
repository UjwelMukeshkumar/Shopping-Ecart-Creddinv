import 'package:equatable/equatable.dart';
import 'product.dart';

class CartItem extends Equatable {
  const CartItem({required this.product, required this.quantity});
  final Product product;
  final int quantity;
  double get lineTotal => product.price * quantity;
  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
  @override
  List<Object?> get props => [product, quantity];
}
