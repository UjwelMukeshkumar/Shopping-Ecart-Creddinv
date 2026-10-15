import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/orders/orders_bloc.dart';
import 'login_page.dart';
import 'orders_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (_, state) =>
          state is AuthFormState && state.status == AuthStatus.loggedOut,
      listener: (context, _) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: const Row(
                children: [
                  CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFFE4E8DE),
                      child: Icon(Icons.person_outline)),
                  SizedBox(width: 12),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Demo User',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        SizedBox(height: 2),
                        Text('demo@threadco.com',
                            style: TextStyle(color: Colors.black54)),
                      ])
                ],
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) => Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(Icons.receipt_long_outlined),
                  title: const Text('My Orders'),
                  subtitle: Text(state.orders.isEmpty
                      ? 'No orders yet'
                      : '${state.orders.length} orders'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrdersPage()),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoggingOut = state is AuthFormState &&
                    state.status == AuthStatus.submitting;
                return Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    trailing: isLoggingOut
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: isLoggingOut
                        ? null
                        : () => context
                            .read<AuthBloc>()
                            .add(const LogoutRequested()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
