// To parse this JSON data, do
//
//     final getLetterResponseModel = getLetterResponseModelFromJson(jsonString);

import 'dart:convert';

GetLetterResponseModel getLetterResponseModelFromJson(String str) => GetLetterResponseModel.fromJson(json.decode(str));

String getLetterResponseModelToJson(GetLetterResponseModel data) => json.encode(data.toJson());

class GetLetterResponseModel {
  bool? success;
  List<SuratList>? suratList;

  GetLetterResponseModel({
    this.success,
    this.suratList,
  });

  factory GetLetterResponseModel.fromJson(Map<String, dynamic> json) => GetLetterResponseModel(
    success: json["success"],
    suratList: json["suratList"] == null ? [] : List<SuratList>.from(json["suratList"]!.map((x) => SuratList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "suratList": suratList == null ? [] : List<dynamic>.from(suratList!.map((x) => x.toJson())),
  };
}

class SuratList {
  String? id;
  String? nim;
  String? nomorSurat;
  String? tanggalPengajuan;
  String? jenisSurat;
  String? namaPemohon;
  String? tujuan;
  String? statusSurat;
  String? keterangan;
  String? nomorTelepon;
  int? v;

  SuratList({
    this.id,
    this.nim,
    this.nomorSurat,
    this.tanggalPengajuan,
    this.jenisSurat,
    this.namaPemohon,
    this.tujuan,
    this.statusSurat,
    this.keterangan,
    this.nomorTelepon,
    this.v,
  });

  factory SuratList.fromJson(Map<String, dynamic> json) => SuratList(
    id: json["_id"],
    nim: json["nim"],
    nomorSurat: json["nomor_surat"],
    tanggalPengajuan: json["tanggal_pengajuan"],
    jenisSurat: json["jenis_surat"],
    namaPemohon: json["nama_pemohon"],
    tujuan: json["tujuan"],
    statusSurat: json["status_surat"],
    keterangan: json["keterangan"],
    nomorTelepon: json["nomor_telepon"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nim": nim,
    "nomor_surat": nomorSurat,
    "tanggal_pengajuan": tanggalPengajuan,
    "jenis_surat": jenisSurat,
    "nama_pemohon": namaPemohon,
    "tujuan": tujuan,
    "status_surat": statusSurat,
    "keterangan": keterangan,
    "nomor_telepon": nomorTelepon,
    "__v": v,
  };
}
