// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourSearchRequest _$TourSearchRequestFromJson(Map<String, dynamic> json) =>
    TourSearchRequest(
      city: json['city'] as String?,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      adults: (json['adults'] as num).toInt(),
      rooms: (json['rooms'] as num).toInt(),
    );

Map<String, dynamic> _$TourSearchRequestToJson(TourSearchRequest instance) =>
    <String, dynamic>{
      if (instance.city case final value?) 'city': value,
      if (instance.fromDate case final value?) 'fromDate': value,
      if (instance.toDate case final value?) 'toDate': value,
      'adults': instance.adults,
      'rooms': instance.rooms,
    };
