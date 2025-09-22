import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/colors/homepage_colors.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/theme/theme.dart';
import 'package:to_do_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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

      theme: lightMode,
    );
  }
}
