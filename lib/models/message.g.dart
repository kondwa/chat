// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      senderUID: json['senderUID'] as String,
      receiverUID: json['receiverUID'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'senderUID': instance.senderUID,
      'receiverUID': instance.receiverUID,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };
