import 'package:flutter/widgets.dart';

import 'app.dart';
import 'data/datasources/local_product_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/watchlist_repository_impl.dart';
import 'domain/usecases/add_to_cart.dart';
import 'domain/usecases/add_to_watchlist.dart';
import 'domain/usecases/authenticate_user.dart';
import 'domain/usecases/clear_cart.dart';
import 'domain/usecases/get_cart.dart';
import 'domain/usecases/get_orders.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/get_watchlist.dart';
import 'domain/usecases/logout_user.dart';
import 'domain/usecases/pay_for_cart.dart';
import 'domain/usecases/remove_from_cart.dart';
import 'domain/usecases/remove_from_watchlist.dart';
import 'domain/usecases/update_cart_quantity.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/cart/cart_bloc.dart';
import 'presentation/bloc/orders/orders_bloc.dart';
import 'presentation/bloc/payment/payment_bloc.dart';
import 'presentation/bloc/products/products_bloc.dart';
import 'presentation/bloc/watchlist/watchlist_bloc.dart';

Widget createApp() {
  final productRepository = ProductRepositoryImpl(LocalProductDataSource());
  final authRepository = AuthRepositoryImpl();
  final cartRepository = CartRepositoryImpl();
  final watchlistRepository = WatchlistRepositoryImpl();

  return ClothingApp(
    authBloc: AuthBloc(
      AuthenticateUser(authRepository),
      LogoutUser(authRepository),
    ),
    productsBloc: ProductsBloc(GetProducts(productRepository)),
    cartBloc: CartBloc(
      getCart: GetCart(cartRepository),
      addToCart: AddToCart(cartRepository),
      removeFromCart: RemoveFromCart(cartRepository),
      updateQuantity: UpdateCartQuantity(cartRepository),
      clearCart: ClearCart(cartRepository),
    ),
    watchlistBloc: WatchlistBloc(
      getWatchlist: GetWatchlist(watchlistRepository),
      addToWatchlist: AddToWatchlist(watchlistRepository),
      removeFromWatchlist: RemoveFromWatchlist(watchlistRepository),
    ),
    ordersBloc: OrdersBloc(GetOrders(cartRepository)),
    paymentBloc: PaymentBloc(PayForCart(cartRepository)),
  );
}
