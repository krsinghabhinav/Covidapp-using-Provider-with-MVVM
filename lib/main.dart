import 'package:covidapp/abhinavsql/showpage.dart';
import 'package:covidapp/sharepreferance.dart/CheckUserDataScreen.dart';
import 'package:covidapp/sharepreferance.dart/UserFormfoput.dart';
import 'package:covidapp/mapdemo.dart';
import 'package:covidapp/page1.dart';
import 'package:covidapp/view/SplashScreen.dart';
import 'package:covidapp/viewModel/worldStateVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'database/local/notesappusingSQFLITE.dart';
import 'sqflitetutorial/sqflitetutorial.dart';
import 'viewModel/countriesViewModel.dart';

void main() {
  // debugPaintSizeEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WorldStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: ShowPage(),
      ),
    );
  }
}
