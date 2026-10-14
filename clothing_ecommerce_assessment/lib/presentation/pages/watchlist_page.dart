import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist/watchlist_bloc.dart';
import '../widgets/product_card.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Your Watchlist')),
      body:
          BlocBuilder<WatchlistBloc, WatchlistState>(builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null && state.products.isEmpty) {
          return Center(child: Text(state.error!));
        }
        if (state.products.isEmpty) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(28),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.favorite_border,
                        size: 56, color: Colors.black38),
                    SizedBox(height: 12),
                    Text('Your watchlist is empty',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Tap the heart on a product to save it here.',
                        textAlign: TextAlign.center)
                  ])));
        }
        return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.products.length,
            itemBuilder: (_, i) => ProductCard(product: state.products[i]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .56));
      }));
}
