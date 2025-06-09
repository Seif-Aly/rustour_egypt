// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRequest _$BookingRequestFromJson(Map<String, dynamic> json) =>
    BookingRequest(
      tourId: (json['tourId'] as num).toInt(),
      bookingDate: json['bookingDate'] as String,
      adults: (json['adults'] as num?)?.toInt(),
      children: (json['children'] as num?)?.toInt(),
      roomId: (json['roomId'] as num?)?.toInt(),
      serviceIds:
          (json['serviceIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
    );

Map<String, dynamic> _$BookingRequestToJson(BookingRequest instance) =>
    <String, dynamic>{
      'tourId': instance.tourId,
      'bookingDate': instance.bookingDate,
      'adults': instance.adults,
      'children': instance.children,
      'roomId': instance.roomId,
      'serviceIds': instance.serviceIds,
    };
