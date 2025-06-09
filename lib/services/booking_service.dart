import 'package:dio/dio.dart';
import '../models/booking.dart';
import '../models/booking_request.dart';
import 'api_client.dart';

class BookingService {
  final Dio _dio = ApiClient().dio;

  Future<void> createBooking(BookingRequest req) async {
    await _dio.post('/bookings', data: req.toJson());
  }

  Future<List<Booking>> myBookings() async {
    final res = await _dio.get('/bookings/my');
    return (res.data as List).map((e) => Booking.fromJson(e)).toList();
  }
}
