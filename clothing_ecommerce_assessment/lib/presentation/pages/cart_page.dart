import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null && state.items.isEmpty) {
          return Center(child: Text(state.error!));
        }
        if (state.isEmpty) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.shopping_bag_outlined,
                        size: 58, color: Colors.black38),
                    SizedBox(height: 12),
                    Text('Your cart is empty',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(
                        'Add a few pieces you love and they will show up here.',
                        textAlign: TextAlign.center)
                  ])));
        }
        return Column(children: [
          Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final item = state.items[i];
                    return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: Row(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(item.product.imageUrl,
                                  width: 82,
                                  height: 94,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const SizedBox(
                                      width: 82,
                                      height: 94,
                                      child: Icon(Icons.checkroom)))),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(item.product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                    '₹${item.product.price.toStringAsFixed(0)}'),
                                const SizedBox(height: 8),
                                Row(children: [
                                  IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(ChangeCartQuantity(
                                              item.product.id,
                                              item.quantity - 1)),
                                      icon: const Icon(
                                          Icons.remove_circle_outline)),
                                  Text('${item.quantity}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(ChangeCartQuantity(
                                              item.product.id,
                                              item.quantity + 1)),
                                      icon:
                                          const Icon(Icons.add_circle_outline))
                                ])
                              ])),
                          IconButton(
                              tooltip: 'Remove item',
                              onPressed: () => context
                                  .read<CartBloc>()
                                  .add(RemoveCartProduct(item.product.id)),
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.red))
                        ]));
                  })),
          Container(
              padding: const EdgeInsets.all(18),
              color: Colors.white,
              child: SafeArea(
                  top: false,
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('₹${state.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w900))
                        ]),
                    const SizedBox(height: 14),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CheckoutPage())),
                            child: const Text('Proceed to Checkout')))
                  ])))
        ]);
      }));
}
