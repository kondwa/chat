// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reportedByUID: json['reportedByUID'] as String,
      messageId: json['messageId'] as String,
      senderUID: json['senderUID'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reportedByUID': instance.reportedByUID,
      'messageId': instance.messageId,
      'senderUID': instance.senderUID,
      'timestamp': instance.timestamp.toIso8601String(),
    };
