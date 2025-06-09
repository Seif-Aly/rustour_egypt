import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rustour_egypt/ui/pages/payment_page.dart';

import '../../models/tour.dart';
import '../../providers/data_providers.dart';

class TourDetailsPage extends ConsumerStatefulWidget {
  const TourDetailsPage({super.key, required this.tour});
  final Tour tour;

  @override
  ConsumerState<TourDetailsPage> createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends ConsumerState<TourDetailsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tour;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (_, __) => [
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 260,
                pinned: true,
                leading: const BackButton(),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(t.imageUrl, fit: BoxFit.cover),
                ),
              ),
            ],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      t.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${t.pricePerAdult}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: const Color(0xFF11B57C)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 2),
                          Text(
                            '${t.ratingValue} (${t.ratingCount})',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            TabBar(
              controller: _tab,
              labelColor: Theme.of(context).colorScheme.primary,
              tabs: const [Tab(text: 'Обзор'), Tab(text: 'Подробно')],
            ),

            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [_OverviewSection(tour: t), _DetailsSection(tour: t)],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: const Color(0xFF11B57C),
                ),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => PaymentPage(t)));
                },
                child: const Text('Забронировать'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewSection extends StatelessWidget {
  const _OverviewSection({required this.tour});
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      children: [
        Text(tour.description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        _InfoRow(
          icon: Icons.schedule,
          label: 'Продолжительность',
          value: '${tour.durationDays} дней',
        ),
        _InfoRow(
          icon: Icons.map,
          label: 'Расстояние',
          value: '${tour.distanceKm} км',
        ),
        _InfoRow(
          icon: Icons.thermostat,
          label: 'Погода',
          value: '${tour.temperatureC} °C, ${tour.weatherState}',
        ),
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.tour});
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      children: [
        if (tour.availableDates != null && tour.availableDates!.isNotEmpty) ...[
          Text(
            'Доступные даты',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children:
                tour.availableDates!
                    .map((d) => _Chip(text: _fmtDate(d.date)))
                    .toList(),
          ),
          const SizedBox(height: 20),
        ],
        if (tour.rooms != null && tour.rooms!.isNotEmpty) ...[
          Text('Типы комнат', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children:
                tour.rooms!
                    .map((r) => _Chip(text: '${r.name} • ${r.capacity} чел'))
                    .toList(),
          ),
          const SizedBox(height: 20),
        ],
        if (tour.services != null && tour.services!.isNotEmpty) ...[
          Text('Услуги', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: tour.services!.map((s) => _Chip(text: s.name)).toList(),
          ),
        ],
      ],
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}
