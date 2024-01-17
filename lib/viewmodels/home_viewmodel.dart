import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const.dart';
import '../locator.dart';
import '../models/get_letter_response_model.dart';
import '../services/alert_service.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

import 'dart:html' as html;

class HomeViewModel extends BaseModel {
  final AlertService _alertService = locator<AlertService>();
  final ApiService _apiService = locator<ApiService>();
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<SuratList> letterList = [];

  ScrollController scrollController = ScrollController();

  TextEditingController searchDataController = TextEditingController();

  void logOut() async {
    _alertService.choiceAlert("Logout", "Keluar dari halaman ini?", "Yes",
            () async {
          await _localStorageService.clearStorage();
          _navigationService.replaceTo(loginViewRoute);
        }, () {
          _navigationService.pop();
        });
  }

  void navigateTo(routeName) {
    _navigationService.replaceTo(routeName);
  }

  void getLetterData() async {
    final data = await _apiService.getLetter();
    if (data == null) {
      _alertService.failedAlert("Gagal", "Internal server error", () {
        _navigationService.pop();
      });
    } else {
      if (data.suratList!.isEmpty) {
        _alertService.warningAlert(
            "Perhatian", "Anda belum melakukan pengajuan surat", () {
          _navigationService.pop();
        });
      } else {
        for (var value in data.suratList!) {
          letterList.add(SuratList(
              id: value.id,
              nim: value.nim,
              nomorSurat: value.nomorSurat,
              tanggalPengajuan: value.tanggalPengajuan,
              jenisSurat: value.jenisSurat,
              namaPemohon: value.namaPemohon,
              tujuan: value.tujuan,
              statusSurat: value.statusSurat,
              v: value.v,
              keterangan: value.keterangan, nomorTelepon: value.nomorTelepon));
        }
        letterList = letterList.reversed.toList();
        setBusy(false);
      }
    }
  }

  List<SuratList> get runFilter {
    String enteredKeyword = searchDataController.text.toLowerCase();

    if (enteredKeyword.isEmpty) {
      // If the search field is empty or only contains white-space, display all letters
      return letterList;
    } else {
      return letterList.where((letter) {
        String nimLowerCase = letter.nim!.toLowerCase();
        String jenisSuratLowerCase = letter.jenisSurat!.toLowerCase();

        return nimLowerCase.contains(enteredKeyword) ||
            jenisSuratLowerCase.contains(enteredKeyword);
      }).toList();
    }
  }


  void searchName() {
    runFilter;
    print('[search] ${searchDataController.text}');
    setBusy(false);
  }

  void questionUpdate(String idSurat, String statusSurat) {
    _alertService.choiceAlert(
        "Status Surat", "Ubah status surat?", "Iya", () {
          _navigationService.pop();
          updateLetter(idSurat, statusSurat);
    }, () {
      _navigationService.pop();
    });
  }

  void updateLetter(String idSurat, String statusSurat) async {
    final data = await _apiService.updateLetter(idSurat, statusSurat);
    if (data == null) {
      _alertService.failedAlert("Gagal", "Internal server error", () {
        _navigationService.pop();
      });
    } else {
      if (data.success == true) {
        _alertService.successAlert(
            "Berhasil", "Status progres surat telah diperbaharui", () {
          _navigationService.replaceTo(homeViewRoute);
        });
      } else {
        _alertService.failedAlert("Gagal", data.message!, () {_navigationService.pop();});
      }
    }
  }

  void launchWhatsApp(String phoneNumber) async {
    final whatsappUrl = 'https://wa.me/$phoneNumber';
    html.window.open(whatsappUrl, 'WhatsApp');
  }
}
