import 'package:front_end_admin_uas24/models/create_user_response_model.dart';
import 'package:front_end_admin_uas24/models/get_all_user_response_model.dart';
import 'package:front_end_admin_uas24/models/update_letter_status_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../models/get_letter_response_model.dart';

class ApiService {
  final baseUrlUser = "http://reza.software-creative-indonesia.my.id/api";

  Future<CreateUserResponseModel?> createUser(
    String nim,
    String password,
    String namaLengkap,
    String programStudi,
    String nomorTelepon,
  ) async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/register');
      var body = jsonEncode({
        "nim": nim,
        "password": password,
        "nama_lengkap": namaLengkap,
        "program_studi": programStudi,
        "nomor_telepon": nomorTelepon
      });
      final response = await client.post(
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        url,
        body: body,
      );
      print('Create User');
      final responseData = createUserResponseModelFromJson(response.body);
      return responseData;
    } catch (e, s) {
      print('[Create User] error occurred $e | $s');
      return null;
    }
  }

  Future<UpdateLetterStatusResponseModel?> updateLetter(
    String idSurat,
      String statusSurat,
  ) async {
    final client = http.Client();
    print("object");
    try {
      final url = Uri.parse('$baseUrlUser/surat/$idSurat');
      var body = jsonEncode({"status_surat": statusSurat});
      final response = await client.put(
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        url,
        body: body,
      );
      final responseData = updateLetterStatusResponseModelFromJson(response.body);
      print(response.body);
      return responseData;
    } catch (e, s) {
      print("[Update Surat $e | $s");
      return null;
    }
  }

  Future<GetLetterResponseModel?> getLetter() async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/AllSurat');
      final response = await client.post(
        url,
      );
      final responseData = getLetterResponseModelFromJson(response.body);
      print('Get Letter');
      return responseData;
    } catch (e,s) {
      print("[Get Letter] $e | $s");
      return null;
    }
  }

  Future<GetAllUserResponseModel?> getUser() async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/AllUser');
      final response = await client.post(
        url,
      );
      final responseData = getAllUserResponseModelFromJson(response.body);
      print('Get Letter');
      return responseData;
    } catch (e,s) {
      print("[Get Letter] $e | $s");
      return null;
    }
  }
}
