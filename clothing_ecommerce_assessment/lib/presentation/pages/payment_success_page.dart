import 'package:flutter/material.dart';
import '../../domain/entities/payment_receipt.dart';
import 'catalog_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key, required this.receipt});
  final PaymentReceipt receipt;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 92,
                        height: 92,
                        decoration: const BoxDecoration(
                            color: Color(0xFFDCE9D9), shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded,
                            size: 54, color: Color(0xFF263B35))),
                    const SizedBox(height: 24),
                    const Text('Payment successful!',
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Text('Thanks for shopping with Thread & Co.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 28),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(children: [
                          const Text('ORDER ID',
                              style: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  color: Colors.black54)),
                          const SizedBox(height: 6),
                          SelectableText(receipt.orderId,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Divider(height: 28),
                          const Text('AMOUNT PAID',
                              style: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  color: Colors.black54)),
                          const SizedBox(height: 6),
                          Text('₹${receipt.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w900)),
                          if (receipt.items.isNotEmpty) ...[
                            const Divider(height: 28),
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('ITEMS',
                                    style: TextStyle(
                                        fontSize: 11,
                                        letterSpacing: 2,
                                        color: Colors.black54))),
                            const SizedBox(height: 8),
                            ...receipt.items.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(
                                          '${item.product.name} × ${item.quantity}')),
                                  Text('₹${item.lineTotal.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700))
                                ])))
                          ]
                        ])),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => const CatalogPage()),
                                (route) => false),
                        child: const Text('Continue Shopping'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
