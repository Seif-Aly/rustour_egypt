import 'package:json_annotation/json_annotation.dart';

part 'booking_request.g.dart';

@JsonSerializable()
class BookingRequest {
  final int tourId;
  final String bookingDate; // ISO8601
  final int adults;
  final int children;
  final int? roomId;
  final List<int>? serviceIds; // если будете отправлять выбранные сервисы

  BookingRequest({
    required this.tourId,
    required this.bookingDate,
    required this.adults,
    required this.children,
    this.roomId,
    this.serviceIds,
  });

  Map<String, dynamic> toJson() => _$BookingRequestToJson(this);
}
