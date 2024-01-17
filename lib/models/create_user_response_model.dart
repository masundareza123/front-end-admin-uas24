// To parse this JSON data, do
//
//     final createUserResponseModel = createUserResponseModelFromJson(jsonString);

import 'dart:convert';

CreateUserResponseModel createUserResponseModelFromJson(String str) => CreateUserResponseModel.fromJson(json.decode(str));

String createUserResponseModelToJson(CreateUserResponseModel data) => json.encode(data.toJson());

class CreateUserResponseModel {
  bool? success;
  User? user;
  String? message;

  CreateUserResponseModel({
    this.success,
    this.user,
    this.message,
  });

  factory CreateUserResponseModel.fromJson(Map<String, dynamic> json) => CreateUserResponseModel(
    success: json["success"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user?.toJson(),
    "message": message,
  };
}

class User {
  String? nim;
  String? password;
  String? namaLengkap;
  String? programStudi;
  String? nomorTelepon;
  String? id;
  int? v;

  User({
    this.nim,
    this.password,
    this.namaLengkap,
    this.programStudi,
    this.nomorTelepon,
    this.id,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    nim: json["nim"],
    password: json["password"],
    namaLengkap: json["nama_lengkap"],
    programStudi: json["program_studi"],
    nomorTelepon: json["nomor_telepon"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "nim": nim,
    "password": password,
    "nama_lengkap": namaLengkap,
    "program_studi": programStudi,
    "nomor_telepon": nomorTelepon,
    "_id": id,
    "__v": v,
  };
}