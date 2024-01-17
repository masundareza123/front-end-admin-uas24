import 'package:flutter/material.dart';
import 'package:front_end_admin_uas24/viewmodels/add_student_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../const.dart';
import '../viewmodels/student_viewmodel.dart';
import 'shared_styles.dart';

class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StudentViewModel(),
      onViewModelReady: (model) => model.getUserData(),
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
            child: model.addForm == false ?
            Column(
              children: [
                verticalSpaceMedium,
                TextField(
                  style: TextStyle(fontSize: 18),
                  onChanged: (value) {
                    value = model.searchDataController.text;
                    model.searchName();
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Cari Berdasarkan NPM',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5),
                  ),
                  controller: model.searchDataController,
                ),
                Container(
                  width: double.infinity,
                  height: 600,
                  child: model.runFilter.isNotEmpty
                      ? ListView.builder(
                    controller: model.scrollController,
                    itemCount: model.runFilter.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin:
                        EdgeInsets.only(top: 15, left: 10, right: 10),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.runFilter[index].namaLengkap!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                Text(
                                  "${model.runFilter[index].nim!}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Text("Program Studi :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2)),
                                Text(
                                    "${model.runFilter[index].programStudi}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 2)),
                                verticalSpaceSmall,
                                Text("Hubungi :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2)),
                                Text(
                                    "${model.runFilter[index].nomorTelepon}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 2)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      : Center(),
                )
              ],
            ) : Container(
              height: 500,
              child: AlertDialog(
                title: Text('Lengkapi Data Mahasiswa'),
                content: Column(
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
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Tambahkan'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      model.createStudent();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
