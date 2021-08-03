// To parse this JSON data, do
//
//     final practicalResult = practicalResultFromJson(jsonString);

import 'dart:convert';

List<PracticalResult> practicalResultFromJson(String str) =>
    List<PracticalResult>.from(
        json.decode(str).map((x) => PracticalResult.fromJson(x)));

String practicalResultToJson(List<PracticalResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PracticalResult {
  PracticalResult({
    this.prId,
    this.prbatchId,
    this.prCandidateId,
    this.prQuestionId,
    this.prMarks,
    this.prNos,
    this.prType,
    this.prNosNavigation,
    this.prQuestion,
    this.prbatch,
  });

  int? prId;
  int? prbatchId;
  String? prCandidateId;
  int? prQuestionId;
  int? prMarks;
  String? prNos;
  bool? prType;
  dynamic prNosNavigation;
  dynamic prQuestion;
  dynamic prbatch;

  factory PracticalResult.fromJson(Map<String, dynamic> json) =>
      PracticalResult(
        prId: json["prId"],
        prbatchId: json["prbatchId"],
        prCandidateId: json["prCandidateId"],
        prQuestionId: json["prQuestionId"],
        prMarks: json["prMarks"] == null ? null : json["prMarks"],
        prNos: json["prNos"] == null ? null : json["prNos"],
        prType: json["prType"],
        prNosNavigation: json["prNosNavigation"],
        prQuestion: json["prQuestion"],
        prbatch: json["prbatch"],
      );

  Map<String, dynamic> toJson() => {
        "prId": prId,
        "prbatchId": prbatchId,
        "prCandidateId": prCandidateId,
        "prQuestionId": prQuestionId,
        "prMarks": prMarks == null ? null : prMarks,
        "prNos": prNos == null ? null : prNos,
        "prType": prType,
        "prNosNavigation": prNosNavigation,
        "prQuestion": prQuestion,
        "prbatch": prbatch,
      };
}
