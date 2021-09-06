import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/screens/autenticacao/login/login_page.dart';

Future<void> main() async {
  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Services services = Services();

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
