import 'package:flutter/cupertino.dart';

import '../const.dart';
import '../locator.dart';
import '../services/alert_service.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AlertService _alertService = locator<AlertService>();
  final ApiService _apiService = locator<ApiService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool loginStatus = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void statusLogged() async {
    loginStatus = await _localStorageService.getBool(localStatusLogin) ?? false;
    if (loginStatus == true) {
      _navigationService.replaceTo(homeViewRoute);
    }
    setBusy(false);
  }

  void loginAdmin() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      _alertService.warningAlert("Perhatian", "Isi semua field yang ada", () {
        _navigationService.pop();
      });
    } else {
      if (usernameController.text == "admin" &&
          passwordController.text == "AdminJaya") {
        await _localStorageService.setBool(localStatusLogin, true);
        _alertService
            .successAlert("Berhasil", "Selamat datang kembali admin TUFAK", () {
          _navigationService.replaceTo(homeViewRoute);
        });
      } else {
        _alertService
            .failedAlert("Gagal", "Username atau password tidak sesuai", () {
          _navigationService.pop();
        });
      }
    }
  }
}
