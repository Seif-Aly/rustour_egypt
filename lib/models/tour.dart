import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class TourDate {
  final int id;
  final int tourId;
  @JsonKey(fromJson: _fromIso, toJson: _toIso)
  final DateTime date;

  const TourDate({required this.id, required this.tourId, required this.date});

  factory TourDate.fromJson(Map<String, dynamic> json) =>
      _$TourDateFromJson(json);
  Map<String, dynamic> toJson() => _$TourDateToJson(this);

  static DateTime _fromIso(String s) => DateTime.parse(s).toLocal();
  static String _toIso(DateTime d) => d.toUtc().toIso8601String();
}

@JsonSerializable()
class RoomType {
  final int id;
  final String name;
  final int capacity;
  const RoomType({
    required this.id,
    required this.name,
    required this.capacity,
  });
  factory RoomType.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RoomTypeToJson(this);
}

@JsonSerializable()
class Service {
  final int id;
  final String name;
  const Service({required this.id, required this.name});
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class Tour extends Equatable {
  final int id;
  final String title;
  final String country;
  final String description;
  final String imageUrl;

  final double ratingValue;
  final int ratingCount;

  final int durationDays;
  final int distanceKm;
  final int temperatureC;
  final String weatherState;

  final double pricePerAdult;
  final double pricePerChild;

  final List<TourDate>? availableDates;
  final List<RoomType>? rooms;
  final List<Service>? services;

  const Tour({
    required this.id,
    required this.title,
    required this.country,
    required this.description,
    required this.imageUrl,
    required this.ratingValue,
    required this.ratingCount,
    required this.durationDays,
    required this.distanceKm,
    required this.temperatureC,
    required this.weatherState,
    required this.pricePerAdult,
    required this.pricePerChild,
    this.availableDates,
    this.rooms,
    this.services,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);
  Map<String, dynamic> toJson() => _$TourToJson(this);

  @override
  List<Object?> get props => [id, title];
}
