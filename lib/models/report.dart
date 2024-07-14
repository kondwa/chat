import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  final String reportedByUID;
  final String messageId;
  final String senderUID;
  final DateTime timestamp;

  Report(
      {required this.reportedByUID,
      required this.messageId,
      required this.senderUID,
      required this.timestamp});

  factory Report.fromJson(json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
