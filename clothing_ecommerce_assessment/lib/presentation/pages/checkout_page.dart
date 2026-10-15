import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/orders/orders_bloc.dart';
import '../bloc/payment/payment_bloc.dart';
import 'payment_success_page.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, paymentState) {
        if (paymentState is PaymentSuccess) {
          context.read<CartBloc>().add(const EmptyCart());
          context.read<OrdersBloc>().add(const LoadOrders());
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) =>
                  PaymentSuccessPage(receipt: paymentState.receipt)));
        }
        if (paymentState is PaymentFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(paymentState.message)));
        }
      }, builder: (context, paymentState) {
        final cart = context.watch<CartBloc>().state;
        return ListView(padding: const EdgeInsets.all(20), children: [
          const Text('ORDER SUMMARY',
              style:
                  TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.5)),
          const SizedBox(height: 16),
          ...cart.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(children: [
                Expanded(
                    child: Text('${item.product.name} × ${item.quantity}')),
                Text('₹${item.lineTotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ]))),
          const Divider(height: 28),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total payable',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('₹${cart.total.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.w900))
          ]),
          const SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color(0xFFEDEFEA),
                  borderRadius: BorderRadius.circular(12)),
              child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(
                            'Demo payment only. No real money will be charged and no payment gateway is connected.'))
                  ])),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: paymentState is PaymentProcessing || cart.isEmpty
                  ? null
                  : () => context
                      .read<PaymentBloc>()
                      .add(InitiatePayment(cart.items)),
              child: paymentState is PaymentProcessing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white)),
                          SizedBox(width: 12),
                          Text('Processing payment...')
                        ])
                  : const Text('Pay Now')),
        ]);
      }));
}
