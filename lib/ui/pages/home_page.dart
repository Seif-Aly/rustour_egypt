import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/data_providers.dart';
import '../../ui/widgets/tour_card.dart';
import 'payment_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTours = ref.watch(toursProvider);

    return asyncTours.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data:
          (tours) => RefreshIndicator(
            onRefresh: () => ref.refresh(toursProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: tours.length,
              itemBuilder: (_, i) {
                final tour = tours[i];
                return InkWell(
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PaymentPage(tour)),
                      ),
                  child: TourCard(tour: tour),
                );
              },
            ),
          ),
    );
  }
}
