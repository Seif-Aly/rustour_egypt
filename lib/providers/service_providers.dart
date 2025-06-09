import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../services/tour_service.dart';
import '../services/user_service.dart';
import '../services/booking_service.dart';

final apiClientProvider = Provider<ApiClient>((_) => ApiClient());

final authServiceProvider = Provider<AuthService>((_) => AuthService());

final tourServiceProvider = Provider<TourService>(
  (ref) => TourService(ref.read(apiClientProvider)),
);

final userServiceProvider = Provider<UserService>((_) => UserService());

final bookingServiceProvider = Provider<BookingService>(
  (_) => BookingService(),
);
