part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddCartProduct extends CartEvent {
  const AddCartProduct(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}

class RemoveCartProduct extends CartEvent {
  const RemoveCartProduct(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class ChangeCartQuantity extends CartEvent {
  const ChangeCartQuantity(this.id, this.quantity);

  final String id;
  final int quantity;

  @override
  List<Object?> get props => [id, quantity];
}

class EmptyCart extends CartEvent {
  const EmptyCart();
}
