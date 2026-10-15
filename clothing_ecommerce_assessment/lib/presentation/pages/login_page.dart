import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import 'catalog_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFormState &&
                        state.status == AuthStatus.success) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const CatalogPage()));
                    }
                  },
                  builder: (context, state) {
                    final form =
                        state is AuthFormState ? state : const AuthFormState();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            height: 76,
                            width: 76,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xFF263B35),
                                borderRadius: BorderRadius.circular(22)),
                            child: const Icon(Icons.checkroom,
                                color: Colors.white, size: 38)),
                        const SizedBox(height: 28),
                        const Text('THREAD & CO.',
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        const Text('Good style starts here.',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        const Text('Sign in to explore the latest collection.',
                            style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 28),
                        const Text('Email address'),
                        const SizedBox(height: 8),
                        TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            onChanged: (v) => context
                                .read<AuthBloc>()
                                .add(LoginEmailChanged(v)),
                            decoration: InputDecoration(
                                hintText: 'demo@threadco.com',
                                prefixIcon: const Icon(Icons.mail_outline),
                                errorText: form.emailError)),
                        const SizedBox(height: 18),
                        const Text('Password'),
                        const SizedBox(height: 8),
                        TextField(
                            controller: _password,
                            obscureText: _obscure,
                            autofillHints: const [AutofillHints.password],
                            onChanged: (v) => context
                                .read<AuthBloc>()
                                .add(LoginPasswordChanged(v)),
                            decoration: InputDecoration(
                                hintText: 'At least 8 characters',
                                prefixIcon: const Icon(Icons.lock_outline),
                                errorText: form.passwordError,
                                suffixIcon: IconButton(
                                    onPressed: () =>
                                        setState(() => _obscure = !_obscure),
                                    icon: Icon(_obscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined)))),
                        if (form.message != null) ...[
                          const SizedBox(height: 12),
                          Text(form.message!,
                              style: const TextStyle(color: Colors.red))
                        ],
                        const SizedBox(height: 24),
                        ElevatedButton(
                            onPressed: form.canSubmit &&
                                    form.status != AuthStatus.submitting
                                ? () => context
                                    .read<AuthBloc>()
                                    .add(const LoginSubmitted())
                                : null,
                            child: form.status == AuthStatus.submitting
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : const Text('Sign In')),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEDEFEA),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Demo credentials',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text('Email: demo@threadco.com'),
                              Text('Password: Flutter123!')
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
