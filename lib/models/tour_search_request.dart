import 'package:json_annotation/json_annotation.dart';

part 'tour_search_request.g.dart';

@JsonSerializable(includeIfNull: false)
class TourSearchRequest {
  final String? city;
  final String? fromDate; // yyyy‑MM‑dd
  final String? toDate; // yyyy‑MM‑dd
  final int adults;
  final int rooms;

  TourSearchRequest({
    this.city,
    this.fromDate,
    this.toDate,
    required this.adults,
    required this.rooms,
  });

  Map<String, dynamic> toJson() => _$TourSearchRequestToJson(this);
}
