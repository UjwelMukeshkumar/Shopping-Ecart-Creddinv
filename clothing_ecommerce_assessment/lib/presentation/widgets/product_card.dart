import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/watchlist/watchlist_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEAE8E1))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Stack(fit: StackFit.expand, children: [
          Image.network(product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFE8E5DD),
                  child: const Icon(Icons.checkroom, size: 48))),
          Positioned(
              right: 8,
              top: 8,
              child: BlocBuilder<WatchlistBloc, WatchlistState>(
                  builder: (context, state) {
                final saved = state.contains(product.id);
                return Material(
                    color: Colors.white.withValues(alpha: .95),
                    shape: const CircleBorder(),
                    child: IconButton(
                        tooltip: saved
                            ? 'Remove from watchlist'
                            : 'Add to watchlist',
                        icon: Icon(
                            saved ? Icons.favorite : Icons.favorite_border,
                            color: saved ? Colors.red : Colors.black87),
                        onPressed: () => context.read<WatchlistBloc>().add(saved
                            ? RemoveWatchlistProduct(product.id)
                            : AddWatchlistProduct(product))));
              })),
        ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 3),
              Text(product.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 8),
              Text('₹${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              BlocBuilder<CartBloc, CartState>(builder: (context, cartState) {
                final itemIndex = cartState.items
                    .indexWhere((item) => item.product.id == product.id);
                final cartItem =
                    itemIndex == -1 ? null : cartState.items[itemIndex];

                if (cartItem == null) {
                  return SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(AddCartProduct(product));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('${product.name} added to cart'),
                                duration: const Duration(seconds: 1)));
                          },
                          icon: const Icon(Icons.add_shopping_cart, size: 17),
                          label: const Text('Add to Cart')));
                }

                return SizedBox(
                    width: double.infinity,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE0DED6)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    final nextQuantity = cartItem.quantity - 1;
                                    context.read<CartBloc>().add(
                                        nextQuantity <= 0
                                            ? RemoveCartProduct(product.id)
                                            : ChangeCartQuantity(
                                                product.id, nextQuantity));
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text('${cartItem.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => context.read<CartBloc>().add(
                                      ChangeCartQuantity(
                                          product.id, cartItem.quantity + 1)),
                                  icon: const Icon(Icons.add)),
                            ])));
              }),
            ])),
      ]));
}
