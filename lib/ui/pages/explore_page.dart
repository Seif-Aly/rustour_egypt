import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/data_providers.dart';
import '../widgets/tour_card.dart';
import 'payment_page.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});
  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  String _category = 'Все';
  static const _cats = ['Все', 'Асуан', 'Сафари', 'Снорклинг'];

  @override
  Widget build(BuildContext context) {
    final tours = ref.watch(toursProvider).value ?? [];

    final filtered =
        _category == 'Все'
            ? tours
            : tours.where((t) => t.title.contains(_category)).toList();

    return Column(
      children: [
        SizedBox(
          height: 46,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _cats.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final c = _cats[i];
              final active = c == _category;
              return ChoiceChip(
                label: Text(c),
                selected: active,
                onSelected: (_) => setState(() => _category = c),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final tour = filtered[i];
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
      ],
    );
  }
}
