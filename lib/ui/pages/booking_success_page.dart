import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ui_state_providers.dart';
import 'my_bookings_page.dart';

class BookingSuccessPage extends ConsumerWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 120, color: Color(0xFF11b57c)),
            const SizedBox(height: 24),
            const Text(
              'Бронирование успешно!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                ref.read(activeTabProvider.notifier).state = 0; // go Home
                Navigator.of(context)
                  ..popUntil((r) => r.isFirst); // clear stack
              },
              child: const Text('На главную'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MyBookingsPage()),
                );
              },
              child: const Text('К моим бронированиям'),
            ),
          ],
        ),
      ),
    );
  }
}
