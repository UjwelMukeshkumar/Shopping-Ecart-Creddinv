import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/cart/cart_bloc.dart';
import 'presentation/bloc/orders/orders_bloc.dart';
import 'presentation/bloc/payment/payment_bloc.dart';
import 'presentation/bloc/products/products_bloc.dart';
import 'presentation/bloc/watchlist/watchlist_bloc.dart';
import 'presentation/pages/login_page.dart';

class ClothingApp extends StatelessWidget {
  const ClothingApp({
    super.key,
    required this.authBloc,
    required this.productsBloc,
    required this.cartBloc,
    required this.watchlistBloc,
    required this.ordersBloc,
    required this.paymentBloc,
  });

  final AuthBloc authBloc;
  final ProductsBloc productsBloc;
  final CartBloc cartBloc;
  final WatchlistBloc watchlistBloc;
  final OrdersBloc ordersBloc;
  final PaymentBloc paymentBloc;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: authBloc),
      BlocProvider.value(value: productsBloc..add(const LoadProducts())),
      BlocProvider.value(value: cartBloc..add(const LoadCart())),
      BlocProvider.value(value: watchlistBloc..add(const LoadWatchlist())),
      BlocProvider.value(value: ordersBloc..add(const LoadOrders())),
      BlocProvider.value(value: paymentBloc),
    ],
    child: MaterialApp(
      title: 'Thread & Co.',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginPage(),
    ),
  );
}
