import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tour.dart';
import '../models/booking.dart';
import '../models/user.dart';
import '../models/tour_search_request.dart';

import 'service_providers.dart';

/// Public list of all tours
final toursProvider = FutureProvider<List<Tour>>((ref) async {
  return ref.read(tourServiceProvider).getAll();
});

/// Filtered search: takes a TourSearchRequest
final searchToursProvider =
    FutureProvider.family<List<Tour>, TourSearchRequest>((ref, criteria) async {
      return ref.read(tourServiceProvider).search(criteria);
    });

/// The currently-authenticated user (or null)
final currentUserProvider = FutureProvider.autoDispose<User?>((ref) async {
  return ref.read(userServiceProvider).getMe();
});

/// My bookings
final bookingsProvider = FutureProvider.autoDispose<List<Booking>>((ref) async {
  return ref.read(bookingServiceProvider).myBookings();
});
