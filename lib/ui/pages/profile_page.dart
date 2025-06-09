import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/data_providers.dart';
import '../../providers/ui_state_providers.dart';
import 'edit_profile_page.dart';
import 'my_bookings_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(meProvider);

    return me.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data:
          (u) => ListView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
            children: [
              // Avatar
              CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                  'https://ui-avatars.com/api/?name=${u.firstName}+${u.lastName}',
                ),
              ),

              const SizedBox(height: 12),

              // Full name
              Center(
                child: Text(
                  '${u.firstName} ${u.lastName}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 22),
                ),
              ),

              // ID
              Center(
                child: Text(
                  'ID: ${u.id}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),

              const SizedBox(height: 32),

              // Edit profile
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Редактировать профиль'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                },
              ),

              // My bookings
              ListTile(
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('Мои бронирования'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MyBookingsPage()),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Выйти'),
                onTap: () {
                  ref.read(activeTabProvider.notifier).state = 0;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Logged out')));
                },
              ),
            ],
          ),
    );
  }
}
