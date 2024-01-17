import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end_admin_uas24/views/home_view.dart';
import 'package:front_end_admin_uas24/views/login_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../services/navigation_service.dart';


import 'locator.dart';
import 'routes.dart';

Future<void> main() async {
runZoned(() async {
    await initializeDateFormatting('id_ID', null).then((_) => runApp(const MyApp()));
  });
  setUpLocator();
  // await FlutterMapTileCaching.initialise();
  // await FMTC.instance('mapStore').manage.createAsync();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);


    return MaterialApp(
      title: 'ADMIN TUFAK 2024',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const SafeArea(
        child: LoginView(),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: generateRoute,
    );
  }
}