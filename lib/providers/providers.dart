import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tour_service.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/booking_service.dart';

final tourServiceProvider = Provider((_) => TourService());
final authServiceProvider = Provider((_) => AuthService());
final userServiceProvider = Provider((_) => UserService());
final bookingServiceProvider = Provider((_) => BookingService());
