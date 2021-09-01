import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/controllers/app_exceptions.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/screens/login/login_page.dart';

Future<void> main() async {
  DataSource dataSource = DataSource();
  Services services = Services();
/*
  do {
    try {
      await services.fetchData("all");
    } catch (e) {
      print("A tentar estabelecer ligação com o servidor." + e.toString());
    }

    print("Trying to connect every 3 sec");
  } while (!dataSource.connected);*/
  /*try {
    var test = await services.fetchData("all");
    dataSource.initialDataFetched = true;
  } catch (e) {
    dataSource.initialDataFetched = false;
    print(e);
  }*/

  print(dataSource.initialDataFetched);

  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => services,
      child: GetMaterialApp(
        title: "Ubiquous Quiz Builder",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF2661FA),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
