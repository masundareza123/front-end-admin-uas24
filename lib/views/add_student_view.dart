import 'package:flutter/material.dart';
import 'package:front_end_admin_uas24/viewmodels/add_student_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../const.dart';
import 'shared_styles.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({Key? key}) : super(key: key);

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddStudentViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: Container(
            width: 40,
            height: 40,
            child: Image.asset("assets/Logo UKRI.png", fit: BoxFit.cover),
          ),
          leadingWidth: 100,
          toolbarHeight: 100,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SISTEM INFORMASI UNIT",
                style: firstStyle,
              ),
              verticalSpaceSuperTiny,
              Text(
                "TATA USAHA FAKULTAS (TUFAK)",
                style: firstStyle,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 25),
              child: Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    model.navigateTo(homeViewRoute);
                  },
                  child: Text(
                    'BERANDA',
                    style: firstStyle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25),
              child: Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    model.navigateTo(studentViewRoute);
                  },
                  child: Text(
                    'DATA MAHASISWA',
                    style: firstStyle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25),
              child: Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    model.navigateTo(addStudentViewRoute);
                  },
                  child: Text(
                    'TAMBAH DATA MAHASISWA',
                    style: firstStyle,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              padding: EdgeInsets.all(10),
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    model.logOut();
                  },
                  child: Text(
                    "Logout",
                    style: firstStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
            )
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpaceMedium,
                Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'NPM',
                        ),
                        controller: model.nimController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                        ),
                        controller: model.nameController,
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Sistem Informasi',
                            groupValue: model.prodiSelected,
                            onChanged: (value) {
                              model.onProdiChanged(value!);
                            },
                          ),
                          Text('Sistem Informasi'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Teknik Informatika',
                            groupValue: model.prodiSelected,
                            onChanged: (value) {
                              model.onProdiChanged(value!);
                            },
                          ),
                          Text('Teknik Informatika'),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                        ),
                        controller: model.phoneNumberController,
                      ),
                      verticalSpaceLarge,
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30),
                        padding: EdgeInsets.all(10),
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              model.createStudent();
                            },
                            child: Text(
                              "Tambahkan",
                              style: firstStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
