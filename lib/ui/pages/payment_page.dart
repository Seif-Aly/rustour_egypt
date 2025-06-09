import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/booking_request.dart';
import '../../models/tour.dart';
import '../../providers/service_providers.dart';
import '../widgets/tour_card.dart';
import 'booking_success_page.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage(this.tour, {Key? key}) : super(key: key);
  final Tour tour;

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  late TourDate? _selected;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.tour.availableDates?.firstOrNull;
  }

  Future<void> _book() async {
    if (_selected == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Выберите дату.')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final bookingSrv = ref.read(bookingServiceProvider);
      final req = BookingRequest(
        tourId: widget.tour.id,
        bookingDate: _selected!.date.toIso8601String(),
      );
      await bookingSrv.createBooking(req);

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BookingSuccessPage()),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dates = widget.tour.availableDates ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Оплата')),
      body: Column(
        children: [
          TourCard(tour: widget.tour),
          const Divider(),
          if (dates.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField<TourDate>(
                value: _selected,
                decoration: const InputDecoration(
                  labelText: 'Дата начала',
                  border: OutlineInputBorder(),
                ),
                items:
                    dates.map((td) {
                      final d = td.date;
                      final label =
                          '${d.day.toString().padLeft(2, '0')}.'
                          '${d.month.toString().padLeft(2, '0')}.'
                          '${d.year}';
                      return DropdownMenuItem(value: td, child: Text(label));
                    }).toList(),
                onChanged: (v) => setState(() => _selected = v),
              ),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _book,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Подтвердить и оплатить'),
            ),
          ),
        ],
      ),
    );
  }
}
