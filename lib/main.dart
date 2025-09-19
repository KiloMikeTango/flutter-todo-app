import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/colors/homepage_colors.dart';
import 'package:to_do_app/pages/home_page.dart';

void main() async {
  //initialize the hive
  await Hive.initFlutter();
  //open box
  await Hive.openBox('userTasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(),

        // checkboxTheme: CheckboxThemeData(
        //   fillColor: WidgetStateProperty.all(checkboxColor),
        // ),
      ),
    );
  }
}
