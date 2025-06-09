import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/data_providers.dart';

class MyBookingsPage extends ConsumerWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBookings = ref.watch(myBookingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Мои бронирования')),
      body: asyncBookings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data:
            (list) =>
                list.isEmpty
                    ? const Center(child: Text('Нет бронирований'))
                    : ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final b = list[i];
                        return ListTile(
                          leading: Image.network(
                            b.tour.imageUrl,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(b.tour.title),
                          subtitle: Text(
                            '${b.bookingDate.day}.${b.bookingDate.month}.${b.bookingDate.year}',
                          ),
                        );
                      },
                    ),
      ),
    );
  }
}
