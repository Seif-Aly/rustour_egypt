import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../services/tour_service.dart';
import '../services/user_service.dart';
import '../services/booking_service.dart';

/// Our shared Dio wrapper
final apiClientProvider = Provider<ApiClient>((_) => ApiClient());

/// AuthService(ApiClient)
final authServiceProvider = Provider<AuthService>((_) => AuthService());

/// TourService(ApiClient)
final tourServiceProvider = Provider<TourService>((_) => TourService());

/// UserService(ApiClient)
final userServiceProvider = Provider<UserService>((_) => UserService());

/// BookingService(ApiClient)
final bookingServiceProvider = Provider<BookingService>(
  (_) => BookingService(),
);
