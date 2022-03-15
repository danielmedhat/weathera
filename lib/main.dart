import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_test/cubit/cubit.dart';
import 'package:my_social_test/dio_helper.dart';
import 'package:my_social_test/home.dart';
import 'package:my_social_test/local/cache_helper.dart';
import 'package:my_social_test/on_boarding.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  MobileAds.instance.initialize();
  DioHelper.inti();
  await CacheHelper.init();
  bool closeBoarding;
  if (CacheHelper.getData(key: 'onBoarding') == null) {
    closeBoarding = false;
  } else {
    closeBoarding = CacheHelper.getData(key: 'onBoarding');
  }
  Widget widget;

  if (closeBoarding) {
    widget = Home();
    print(closeBoarding);
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ) );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..checkInternet()

        ..getHomeData()
        ..myBanner.load(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.grey[300])),
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: startWidget),
    );
  }
}





//https://api.openweathermap.org/data/2.5/weather?q=London&APPID=0a553ec460d72d7d68d2ec7290853d45