import 'package:flutter/material.dart';
import 'package:front_end_admin_uas24/viewmodels/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../const.dart';
import 'shared_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedStatus = 'Online';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.getLetterData(),
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
                  TextField(
                    style: TextStyle(fontSize: 18),
                    onChanged: (value) {
                      value = model.searchDataController.text;
                      model.searchName();
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'Cari Berdasarkan NPM dan Jenis Surat',
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
                                margin: EdgeInsets.only(
                                    top: 15, left: 10, right: 10),
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
                                          model.runFilter[index].jenisSurat!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 2),
                                        ),
                                        Text(
                                          "Diajukan pada ${model.runFilter[index].tanggalPengajuan!}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 2),
                                        ),
                                        verticalSpaceSmall,
                                        Text("Status :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2)),
                                        Text(
                                            model.runFilter[index].statusSurat!,
                                            style: TextStyle(
                                                color: model.runFilter[index]
                                                            .statusSurat ==
                                                        "decline"
                                                    ? Colors.red
                                                    : model.runFilter[index]
                                                                .statusSurat ==
                                                            "finish"
                                                        ? Colors.green
                                                        : model.runFilter[index]
                                                                    .statusSurat ==
                                                                "process"
                                                            ? Colors.orange
                                                            : Colors.black45,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2)),
                                        verticalSpaceSmall,
                                        Text("Pemohon :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2)),
                                        Text(
                                            "${model.runFilter[index].nim} - ${model.runFilter[index].namaPemohon}",
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
                                        InkWell(
                                          onTap: (){
                                            model.launchWhatsApp(model.runFilter[index].nomorTelepon!);
                                          },
                                          child: Text(
                                              "${model.runFilter[index].nomorTelepon}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 2)),
                                        ),
                                        verticalSpaceSmall,
                                        Text(
                                          "Keterangan ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 2),
                                        ),
                                        Container(
                                          width: 800,
                                          child: Text(
                                            model.runFilter[index].keterangan!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ganti status pemrosesan",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 2),
                                        ),
                                        verticalSpaceMedium,
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                model.questionUpdate(model.letterList[index].id!, "waiting");
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.black, // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Waiting",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700,
                                                        letterSpacing: 2),

                                                  ),
                                                ),
                                              ),
                                            ),
                                            horizontalSpaceSmall,
                                            InkWell(
                                              onTap: (){
                                                model.questionUpdate(model.letterList[index].id!, "process");
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Process",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700,
                                                        letterSpacing: 2),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        verticalSpaceSmall,
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                model.questionUpdate(model.letterList[index].id!, "finish");
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Finish",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700,
                                                        letterSpacing: 2),

                                                  ),
                                                ),
                                              ),
                                            ),
                                            horizontalSpaceSmall,
                                            InkWell(
                                              onTap: (){
                                                model.questionUpdate(model.letterList[index].id!, "decline");
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Decline",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700,
                                                        letterSpacing: 2),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
