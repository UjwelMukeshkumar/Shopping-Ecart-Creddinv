import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/products/products_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/watchlist/watchlist_bloc.dart';
import '../widgets/product_card.dart';
import 'watchlist_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('THREAD & CO.',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 16)),
                Text('Wear what feels like you',
                    style: TextStyle(fontSize: 12, color: Colors.black54))
              ]),
          actions: [
            IconButton(
                tooltip: 'Profile',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfilePage())),
                icon: const Icon(Icons.person_outline)),
            IconButton(
                tooltip: 'Watchlist',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const WatchlistPage())),
                icon: BlocBuilder<WatchlistBloc, WatchlistState>(
                    builder: (_, s) => Badge(
                        label: Text('${s.products.length}'),
                        child: const Icon(Icons.favorite_border)))),
            IconButton(
                tooltip: 'Cart',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartPage())),
                icon: BlocBuilder<CartBloc, CartState>(
                    builder: (_, s) => Badge(
                        label: Text('${s.itemCount}'),
                        child: const Icon(Icons.shopping_bag_outlined))))
          ]),
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductsLoading || state is ProductsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductsFailure) {
          return _message(state.message, Icons.error_outline,
              () => context.read<ProductsBloc>().add(const LoadProducts()));
        }
        if (state is ProductsEmpty) {
          return _message(
              'No products available yet.',
              Icons.inventory_2_outlined,
              () => context.read<ProductsBloc>().add(const LoadProducts()));
        }
        if (state is ProductsLoaded) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE4E8DE),
                      borderRadius: BorderRadius.circular(18)),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('THE NEW EDIT',
                            style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Everyday pieces.\nEffortless style.',
                            style: TextStyle(
                                fontSize: 26,
                                height: 1.15,
                                fontWeight: FontWeight.w800)),
                        SizedBox(height: 8),
                        Text('Thoughtfully selected staples for your wardrobe.')
                      ])),
            )),
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        (context, i) => ProductCard(product: state.products[i]),
                        childCount: state.products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: .56))),
          ]);
        }
        return const SizedBox.shrink();
      }));
  Widget _message(String text, IconData icon, VoidCallback retry) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 44),
              const SizedBox(height: 12),
              Text(text, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: retry, child: const Text('Try again'))
            ],
          ),
        ),
      );
}
