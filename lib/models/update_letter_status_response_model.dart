// To parse this JSON data, do
//
//     final updateLetterStatusResponseModel = updateLetterStatusResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateLetterStatusResponseModel updateLetterStatusResponseModelFromJson(String str) => UpdateLetterStatusResponseModel.fromJson(json.decode(str));

String updateLetterStatusResponseModelToJson(UpdateLetterStatusResponseModel data) => json.encode(data.toJson());

class UpdateLetterStatusResponseModel {
  bool? success;
  String? message;

  UpdateLetterStatusResponseModel({
    this.success,
    this.message,
  });

  factory UpdateLetterStatusResponseModel.fromJson(Map<String, dynamic> json) => UpdateLetterStatusResponseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}