import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rustour_egypt/providers/data_providers.dart';
import 'package:rustour_egypt/providers/service_providers.dart';
import '../../services/auth_service.dart';
import '../../providers/ui_state_providers.dart';
import '../main_layout.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final auth = ref.read(authServiceProvider);
      final user = await auth.register(
        firstName: _firstCtrl.text.trim(),
        lastName: _lastCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );
      ref.read(meProvider.notifier).state = AsyncValue.data(user);

      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainLayout()));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final msg =
            (e.response?.data is Map && e.response!.data['message'] != null)
                ? e.response!.data['message'] as String
                : 'Неверные данные или email уже используется';
        setState(() => _error = msg);
      } else {
        setState(() => _error = 'Ошибка: ${e.message}');
      }
    } catch (e) {
      setState(() => _error = 'Unexpected error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstCtrl,
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (v) => v!.isEmpty ? 'Введите имя' : null,
              ),
              TextFormField(
                controller: _lastCtrl,
                decoration: const InputDecoration(labelText: 'Фамилия'),
                validator: (v) => v!.isEmpty ? 'Введите фамилию' : null,
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.contains('@') ? null : 'Неверный email',
              ),
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Пароль'),
                obscureText: true,
                validator: (v) => v!.length < 6 ? 'Не менее 6 символов' : null,
              ),

              const SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _loading ? null : _register,
                child:
                    _loading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
