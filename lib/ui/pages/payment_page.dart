import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/tour.dart';
import '../../providers/data_providers.dart';
import '../widgets/tour_card.dart';
import 'booking_success_page.dart';
import '../../providers/providers.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage(this.tour, {super.key});
  final Tour tour;

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  bool _isLoading = false;

  Future<void> _book() async {
    setState(() => _isLoading = true);
    final bookingSrv = ref.read(bookingServiceProvider);
    await bookingSrv.create(
      tourId: widget.tour.id,
      date: widget.tour.availableDates!.first.date,
    );
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BookingSuccessPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Оплата')),
    body: Column(
      children: [
        TourCard(widget.tour),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _isLoading ? null : _book,
            child:
                _isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Подтвердить и оплатить'),
          ),
        ),
      ],
    ),
  );
}
