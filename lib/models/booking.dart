import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'tour.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking extends Equatable {
  final int id;
  final int tourId;
  @JsonKey(fromJson: _fromIso, toJson: _toIso)
  final DateTime bookingDate;
  final Tour tour; // сервер отдаёт Tour внутрь /bookings/my

  const Booking({
    required this.id,
    required this.tourId,
    required this.bookingDate,
    required this.tour,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);

  static DateTime _fromIso(String s) => DateTime.parse(s).toLocal();
  static String _toIso(DateTime d) => d.toUtc().toIso8601String();

  @override
  List<Object?> get props => [id, tourId];
}
