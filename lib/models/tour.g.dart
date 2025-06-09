// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourDate _$TourDateFromJson(Map<String, dynamic> json) => TourDate(
  id: (json['id'] as num).toInt(),
  tourId: (json['tourId'] as num).toInt(),
  date: TourDate._fromIso(json['date'] as String),
);

Map<String, dynamic> _$TourDateToJson(TourDate instance) => <String, dynamic>{
  'id': instance.id,
  'tourId': instance.tourId,
  'date': TourDate._toIso(instance.date),
};

RoomType _$RoomTypeFromJson(Map<String, dynamic> json) => RoomType(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  capacity: (json['capacity'] as num).toInt(),
);

Map<String, dynamic> _$RoomTypeToJson(RoomType instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'capacity': instance.capacity,
};

Service _$ServiceFromJson(Map<String, dynamic> json) =>
    Service(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

Tour _$TourFromJson(Map<String, dynamic> json) => Tour(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  country: json['country'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String,
  ratingValue: (json['ratingValue'] as num).toDouble(),
  ratingCount: (json['ratingCount'] as num).toInt(),
  durationDays: (json['durationDays'] as num).toInt(),
  distanceKm: (json['distanceKm'] as num).toInt(),
  temperatureC: (json['temperatureC'] as num).toInt(),
  weatherState: json['weatherState'] as String,
  pricePerAdult: (json['pricePerAdult'] as num).toDouble(),
  pricePerChild: (json['pricePerChild'] as num).toDouble(),
  availableDates:
      (json['availableDates'] as List<dynamic>?)
          ?.map((e) => TourDate.fromJson(e as Map<String, dynamic>))
          .toList(),
  rooms:
      (json['rooms'] as List<dynamic>?)
          ?.map((e) => RoomType.fromJson(e as Map<String, dynamic>))
          .toList(),
  services:
      (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'country': instance.country,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'ratingValue': instance.ratingValue,
  'ratingCount': instance.ratingCount,
  'durationDays': instance.durationDays,
  'distanceKm': instance.distanceKm,
  'temperatureC': instance.temperatureC,
  'weatherState': instance.weatherState,
  'pricePerAdult': instance.pricePerAdult,
  'pricePerChild': instance.pricePerChild,
  'availableDates': instance.availableDates,
  'rooms': instance.rooms,
  'services': instance.services,
};
