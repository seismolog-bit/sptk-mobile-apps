import 'package:flutter/material.dart';
import 'package:sptk/screens/tabs.dart';
import 'package:sptk/utils/ad/app_lifecycle_reactor.dart';
import 'package:sptk/utils/ad/app_open_ad_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    WidgetsBinding.instance!
        .addObserver(AppLifecycleReactor(appOpenAdManager: appOpenAdManager));
  }

  @override
  Widget build(BuildContext context) {
    return const TabsScreen(
      initialPage: 1,
    );
  }
}