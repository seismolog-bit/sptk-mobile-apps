import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/screens/home/home_page.dart';
import 'package:sptk/screens/tabs.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    // await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpatika | SekolahPendidik.Com',
      theme: ThemeData(
        primaryColor: ThemeColors.primary,
        scaffoldBackgroundColor: ThemeColors.white,
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: ThemeColors.primary),
          titleTextStyle: TextStyle(
            color: ThemeColors.secondary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
    );
  }
}
