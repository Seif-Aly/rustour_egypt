import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tour.dart';
import '../models/booking.dart';
import '../models/user.dart';
import '../models/tour_search_request.dart';

import 'service_providers.dart';

final toursProvider = FutureProvider<List<Tour>>((ref) async {
  return ref.read(tourServiceProvider).getAll();
});

final searchToursProvider =
    FutureProvider.family<List<Tour>, TourSearchRequest>((ref, criteria) async {
      return ref.read(tourServiceProvider).search(criteria);
    });

final currentUserProvider = FutureProvider.autoDispose<User?>((ref) async {
  return ref.read(userServiceProvider).getMe();
});

final bookingsProvider = FutureProvider.autoDispose<List<Booking>>((ref) async {
  return ref.read(bookingServiceProvider).myBookings();
});

final myBookingsProvider = FutureProvider<List<Booking>>((ref) async {
  final bookingService = ref.read(bookingServiceProvider);
  return bookingService.myBookings();
});

final meProvider = StateProvider<AsyncValue<User>>(
  (ref) => const AsyncValue.loading(),
);
