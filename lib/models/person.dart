import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  final String uid;
  final String email;
  final String displayName;

  Person({required this.uid, required this.email, required this.displayName});

  factory Person.fromJson(json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
