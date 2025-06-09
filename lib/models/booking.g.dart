// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  id: (json['id'] as num).toInt(),
  tourId: (json['tourId'] as num).toInt(),
  bookingDate: Booking._fromIso(json['bookingDate'] as String),
  tour: Tour.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'id': instance.id,
  'tourId': instance.tourId,
  'bookingDate': Booking._toIso(instance.bookingDate),
  'tour': instance.tour,
};
