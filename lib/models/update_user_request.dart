import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  UpdateUserRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
