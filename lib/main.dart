
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opgg/binding/app_binding.dart';
import 'package:opgg/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: AppBinding(),
      home: HomeScreen(),
    );
  }
}
