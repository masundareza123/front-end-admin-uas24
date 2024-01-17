import 'package:flutter/cupertino.dart';
import 'package:front_end_admin_uas24/const.dart';
import 'package:front_end_admin_uas24/models/get_all_user_response_model.dart';

import '../locator.dart';
import '../models/get_letter_response_model.dart';
import '../services/alert_service.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class AddStudentViewModel extends BaseModel {
  final AlertService _alertService = locator<AlertService>();
  final ApiService _apiService = locator<ApiService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController nimController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? prodiSelected;

  List<User> userList = [];

  ScrollController scrollController = ScrollController();

  TextEditingController searchDataController = TextEditingController();

  bool addForm = false;

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

  void onProdiChanged(String value){
    print(value);
    prodiSelected = value;
    setBusy(false);
  }

  void createStudent() async {
    if (nimController.text.isEmpty ||
        nameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        prodiSelected == null) {
      _alertService
          .warningAlert("Perhatian", "Lengkapi semua data yang diperlukan", () {
        _navigationService.pop();
      });

    } else {
      final data = await _apiService.createUser(
          nimController.text.trim(),
          "123456",
          nameController.text,
          prodiSelected!,
          phoneNumberController.text);
      if (data == null) {
        _alertService.failedAlert("Gagal", "Internal server error", () {
          _navigationService.pop();
        });
      } else {
        if (data.success == true) {
          _alertService.successAlert(
              "Berhasil", "Data akun mahasiswa telah ditambahkan", () {
                _navigationService.replaceTo(addStudentViewRoute);
          });
        } else {
          _alertService.failedAlert("Gagal", data.message!, () {
            _navigationService.pop();
          });
        }
      }
    }
  }

  void getUserData() async {
    final data = await _apiService.getUser();
    if (data == null) {
      _alertService.failedAlert("Gagal", "Internal server error", () {
        _navigationService.pop();
      });
    } else {
      if (data.users!.isEmpty) {
        _alertService.warningAlert(
            "Perhatian", "Anda belum melakukan pengajuan surat", () {
          _navigationService.pop();
        });
      } else {
        for (var value in data.users!) {
          userList.add(User(
              id: value.id,
            nim: value.nim,
            password: value.password,
            namaLengkap: value.namaLengkap,
            programStudi: value.programStudi,
            nomorTelepon: value.nomorTelepon,
            v: value.v
          ));
        }
        userList = userList.reversed.toList();
        setBusy(false);
      }
    }
  }

  List<User> get runFilter {
    String enteredKeyword = searchDataController.text;
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      return userList;
    } else {
      return userList
          .where((user) =>
          user.nim!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
  }

  void searchName() {
    runFilter;
    print('[search] ${searchDataController.text}');
    setBusy(false);
  }
}
