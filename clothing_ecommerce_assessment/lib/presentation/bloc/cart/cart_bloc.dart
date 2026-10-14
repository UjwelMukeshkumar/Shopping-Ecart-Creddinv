import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_cart.dart';
import '../../../domain/usecases/add_to_cart.dart';
import '../../../domain/usecases/remove_from_cart.dart';
import '../../../domain/usecases/update_cart_quantity.dart';
import '../../../domain/usecases/clear_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(
      {required this.getCart,
      required this.addToCart,
      required this.removeFromCart,
      required this.updateQuantity,
      required this.clearCart})
      : super(const CartState()) {
    on<LoadCart>((e, emit) async {
      emit(CartState(items: state.items, loading: true));
      try {
        emit(CartState(items: await getCart()));
      } catch (_) {
        emit(const CartState(error: 'Could not load cart.'));
      }
    });
    on<AddCartProduct>((e, emit) async {
      try {
        emit(CartState(items: await addToCart(e.product)));
      } catch (_) {
        emit(CartState(items: state.items, error: 'Could not add product.'));
      }
    });
    on<RemoveCartProduct>((e, emit) async {
      try {
        emit(CartState(items: await removeFromCart(e.id)));
      } catch (_) {
        emit(CartState(items: state.items, error: 'Could not remove product.'));
      }
    });
    on<ChangeCartQuantity>((e, emit) async {
      try {
        emit(CartState(items: await updateQuantity(e.id, e.quantity)));
      } catch (_) {
        emit(
            CartState(items: state.items, error: 'Could not update quantity.'));
      }
    });
    on<EmptyCart>((e, emit) async {
      try {
        emit(CartState(items: await clearCart()));
      } catch (_) {
        emit(CartState(items: state.items, error: 'Could not clear cart.'));
      }
    });
  }
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartQuantity updateQuantity;
  final ClearCart clearCart;
}
