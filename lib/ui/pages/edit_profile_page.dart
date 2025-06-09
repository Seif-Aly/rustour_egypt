import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/update_user_request.dart';
import '../../providers/data_providers.dart';
import '../../providers/service_providers.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final usrSvc = ref.read(userServiceProvider);

    final req = UpdateUserRequest(
      firstName: _firstCtrl.text.trim(),
      lastName: _lastCtrl.text.trim(),
    );

    try {
      await usrSvc.updateMe(req);
      ref.invalidate(currentUserProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать профиль')),
      body: userAsync.when(
        loading:
            () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (u) {
          _firstCtrl.text = u?.firstName ?? '';
          _lastCtrl.text = u?.lastName ?? '';

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: _firstCtrl,
                  decoration: const InputDecoration(labelText: 'Имя'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _lastCtrl,
                  decoration: const InputDecoration(labelText: 'Фамилия'),
                ),
                const SizedBox(height: 24),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child:
                      _saving
                          ? const CircularProgressIndicator.adaptive()
                          : const Text('Сохранить'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
