import 'package:json_annotation/json_annotation.dart';

part 'booking_request.g.dart';

@JsonSerializable()
class BookingRequest {
  final int tourId;
  final String bookingDate;
  final int? adults;
  final int? children;
  final int? roomId;
  final List<int>? serviceIds;

  BookingRequest({
    required this.tourId,
    required this.bookingDate,
    this.adults,
    this.children,
    this.roomId,
    this.serviceIds,
  });

  Map<String, dynamic> toJson() => _$BookingRequestToJson(this);
}
