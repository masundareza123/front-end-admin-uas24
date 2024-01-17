import 'package:flutter/material.dart';
import 'package:front_end_admin_uas24/viewmodels/login_viewmodel.dart';
import 'package:front_end_admin_uas24/views/shared_styles.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onViewModelReady: (model) => model.statusLogged(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Column(
                  children: [
                    verticalSpaceLarge,
                    Text(
                      "MASUKAN AKUN ADMIN UNTUK MELANJUTKAN",
                      style: secondStyle,
                    ),
                    verticalSpaceMassive,
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: "Username"),
                            controller: model.usernameController,
                          ),
                          verticalSpaceMedium,
                          TextFormField(
                            decoration: InputDecoration(labelText: "Password"),
                            controller: model.passwordController,
                          ),
                          verticalSpaceLarge,
                          Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  model.loginAdmin();
                                },
                                child: Text(
                                  "Login",
                                  style: firstStyle,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
