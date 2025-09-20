import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lotto/pages/admin/Random.dart';
import 'package:lotto/pages/admin/admin.dart';
import 'package:lotto/pages/admin/make.dart';
import 'package:lotto/pages/home.dart';
import 'package:lotto/pages/info.dart';
import 'package:lotto/pages/mylotto.dart';
import 'package:lotto/pages/page_claim_lotto.dart';
import 'package:lotto/pages/page_login.dart';
import 'package:lotto/pages/page_search_lotto.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: GoogleFonts.notoSansThaiLoopedTextTheme(),),
      home: const LoginScreen(),
    );
  }
}
