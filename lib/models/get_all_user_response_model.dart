// To parse this JSON data, do
//
//     final getAllUserResponseModel = getAllUserResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllUserResponseModel getAllUserResponseModelFromJson(String str) => GetAllUserResponseModel.fromJson(json.decode(str));

String getAllUserResponseModelToJson(GetAllUserResponseModel data) => json.encode(data.toJson());

class GetAllUserResponseModel {
  bool? success;
  List<User>? users;

  GetAllUserResponseModel({
    this.success,
    this.users,
  });

  factory GetAllUserResponseModel.fromJson(Map<String, dynamic> json) => GetAllUserResponseModel(
    success: json["success"],
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  String? id;
  String? nim;
  String? password;
  String? namaLengkap;
  String? programStudi;
  String? nomorTelepon;
  int? v;

  User({
    this.id,
    this.nim,
    this.password,
    this.namaLengkap,
    this.programStudi,
    this.nomorTelepon,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    nim: json["nim"],
    password: json["password"],
    namaLengkap: json["nama_lengkap"],
    programStudi: json["program_studi"],
    nomorTelepon: json["nomor_telepon"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nim": nim,
    "password": password,
    "nama_lengkap": namaLengkap,
    "program_studi": programStudi,
    "nomor_telepon": nomorTelepon,
    "__v": v,
  };
}