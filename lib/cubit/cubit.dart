import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_social_test/cubit/states.dart';
import 'package:my_social_test/dio_helper.dart';
import 'package:my_social_test/home.dart';
import 'package:my_social_test/local/cache_helper.dart';
import 'package:my_social_test/models/home_model.dart';
import 'package:my_social_test/on_boarding.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  BannerAd? anchoredBanner;
  bool _loadingAnchoredBanner = false;
  var min;
  var max;
  var temp;
  var code;
  var country;
  var city = CacheHelper.getData(key: 'city');
  HomeModel? homeModel;
  bool? connectionResult;

  TextEditingController? controllerr;

  static AppCubit get(contaxt) => BlocProvider.of(contaxt);
  void checkInternet()async{
    connectionResult = await InternetConnectionChecker().hasConnection;
    print(connectionResult.toString()+"hhhh");
    emit(AppCheckInternetState());
  }

   Future <void> getHomeData() async {
    emit(AppGetLoadingState());
   await DioHelper.getDta(
            query: {'q': '$city', 'APPID': '0a553ec460d72d7d68d2ec7290853d45'},
            url: 'data/2.5/weather')
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(value.data['main']['temp_max'].toString());
      min = (value.data['main']['temp_min'] - 272.5).round();
      max = (value.data['main']['temp_max'] - 272.5).round();
      temp = (value.data['main']['temp'] - 272.5).round();
      code = (value.data['cod']);
      country = value.data['sys']['country'];
      print('${homeModel!.message}' + 'dddd');
      print(homeModel!.weather[0].icon);
      // print(value.data['weather']);
      // print(value.data['name']);
      // print(code);

      emit(AppGetSuccessState());
    }).catchError((error) {
      homeModel = HomeModel.fromJson(error);
      print(homeModel!.message);
      print(error.toString());

      emit(AppGetErrorState());
    });
  }
  
 

  final BannerAd myBanner = BannerAd(
    adUnitId: //'ca-app-pub-1793256327308832/9991443732',
    //'ca-app-pub-3940256099942544/6300978111',
    'ca-app-pub-1793256327308832/8370167505',
     //ca-app-pub-1793256327308832/8370167505
    size: AdSize.smartBannerPortrait,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad){
     
      
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

// Future<void> _createAnchoredBanner(BuildContext context) async {
//     final AnchoredAdaptiveBannerAdSize? size =
//         await AdSize.getAnchoredAdaptiveBannerAdSize(
//       Orientation.portrait,
//       MediaQuery.of(context).size.width.truncate(),
//     );

//     if (size == null) {
//       print('Unable to get height of anchored banner.');
//       return;
//     }

//     final BannerAd banner = BannerAd(
//       size: size,
//       request: AdRequest(),
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/6300978111'
//           : 'ca-app-pub-3940256099942544/2934735716',
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$BannerAd loaded.');

//            anchoredBanner = ad as BannerAd?;

//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$BannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//       ),
//     );
//     return banner.load();
//   }

}
