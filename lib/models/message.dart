import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String senderUID;
  final String receiverUID;
  final String message;
  final DateTime timestamp;

  Message(
      {required this.id,
      required this.senderUID,
      required this.receiverUID,
      required this.message,
      required this.timestamp});

  factory Message.fromJson(json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
