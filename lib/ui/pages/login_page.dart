import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/service_providers.dart';
import '../../providers/data_providers.dart';
import '../main_layout.dart';
import 'signup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    // 1) Validate form fields
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // 2) Call AuthService.login
      final user = await ref
          .read(authServiceProvider)
          .login(_emailCtrl.text.trim(), _passCtrl.text);

      // 3) Store user in meProvider so Profile can read it
      ref.read(meProvider.notifier).state = AsyncValue.data(user);

      // 4) Navigate to MainLayout (home)
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayout()),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        setState(() => _error = 'Неверный email или пароль');
      } else {
        setState(() => _error = 'Ошибка: ${e.message}');
      }
    } catch (e) {
      setState(() => _error = 'Unexpected error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Введите email';
                  final re = RegExp(r'^[\w.+-]+@[\w-]+\.[\w-]+');
                  if (!re.hasMatch(v)) return 'Неверный формат email';
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Password
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Пароль'),
                obscureText: true,
                validator:
                    (v) => v == null || v.isEmpty ? 'Введите пароль' : null,
              ),

              const SizedBox(height: 24),

              // Server‐side or catch‐all error
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 8),

              // Login button
              ElevatedButton(
                onPressed: _loading ? null : _login,
                child:
                    _loading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Войти'),
              ),

              // Go to signup
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const SignupPage()));
                },
                child: const Text('Нет аккаунта? Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
