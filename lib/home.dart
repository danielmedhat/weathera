

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_social_test/cubit/cubit.dart';
import 'package:my_social_test/cubit/states.dart';
import 'package:my_social_test/local/cache_helper.dart';
import 'package:my_social_test/main.dart';
import 'package:my_social_test/on_boarding.dart';

class Home extends StatelessWidget {
  var cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var cityController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final AdWidget adWidget =
            AdWidget(ad: AppCubit.get(context).myBanner);
        void search() async {
          AppCubit.get(context).city = cityController.text;
          try {
            AppCubit.get(context).getHomeData();
          } catch (error) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false);

            print(error.toString());
          }
        }
       

        if (state is AppGetSuccessState&&AppCubit.get(context).connectionResult==true) {

          return Scaffold(
            appBar: null,
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.grey[900],
                    // decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         begin: Alignment.topCenter,
                    //         end: Alignment.bottomCenter,
                    //         colors: [Colors.yellow, Colors.lightBlueAccent])),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        
                        ListView(
                          children: [
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${AppCubit.get(context).city}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 50),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${AppCubit.get(context).country}',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30),
                                      child: Container(
                                          height:height*0.22,
                                          width: height*0.22,
                                          child: Image(
                                            image: AssetImage(
                                                'images/cloudy.png'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        (AppCubit.get(context).homeModel)==null?'Loading..':AppCubit.get(context).homeModel!.weather[0].main,
                                        style:TextStyle(color: Colors.amber,
                                        fontSize: 30
                                        ) ,),
                                    ),
                                      SizedBox(
                                        height: height*0.07,
                                      ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(16.0),
                                    //   child: Row(
                                    //     children: [
                                    //       // IconButton(
                                    //       //     color: Colors.blue,
                                    //       //     iconSize: 40,
                                    //       //     onPressed: () {
                                    //       //       search();
                                    //       //       print(cityController.text);
                                    //       //     },
                                    //       //     icon: Icon(Icons.search)),
                                    //       Expanded(
                                    //         child: TextFormField(
                                    //           onFieldSubmitted: (value) {
                                    //             search();
                                    //           },
                                    //           controller: cityController,
                                    //           decoration: InputDecoration(
                                    //             prefixIcon: Icon(
                                    //               Icons.search,
                                    //               color:
                                    //                   Colors.lightBlueAccent,
                                    //             ),
                                    //             hintText: 'City Name',
                                    //             filled: true,
                                    //             fillColor: Colors.white,
                                    //             enabledBorder:
                                    //                 OutlineInputBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(20),
                                    //                     borderSide:
                                    //                         BorderSide(
                                    //                             color: Colors
                                    //                                 .white)),
                                    //             focusedBorder:
                                    //                 OutlineInputBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(20),
                                    //                     borderSide:
                                    //                         BorderSide(
                                    //                             color: Colors
                                    //                                 .white)),
                                    //             border: OutlineInputBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         20),
                                    //                 borderSide: BorderSide(
                                    //                     color: Colors.white)),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Column(
                                      children: [
                                        Text(
                                          'Temp',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                        Text(
                                          '${AppCubit.get(context).temp}' +
                                              '  C',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Min',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                              Text(
                                                '${AppCubit.get(context).min}' +
                                                    "  C",
                                                style: TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                'Max',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                              Text(
                                                '${AppCubit.get(context).max}' +
                                                    '  C',
                                                style: TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 20),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        
                        Container(
                            height: 130,
                            width: double.infinity,
                            child: adWidget),
                      ],
                    ),
                
                    // color: Colors.green,
                    // width: AppCubit.get(context).anchoredBanner!.size.width.toDouble(),
                    // height: AppCubit.get(context).anchoredBanner!.size.height.toDouble(),
                    // child: AdWidget(ad: AppCubit.get(context).anchoredBanner!),)
                  ),
                ),
              ],
            ),
          );
        } else if(AppCubit.get(context).connectionResult==true&& state is AppGetErrorState){
         return Scaffold(
            appBar: null,
            body: Container(
              height: height,
                    width: width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.yellow, Colors.lightBlueAccent])),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Invalid City Name Please ',
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnBoardingScreen()),
                              (route) => false);
                        },
                        child: Text('Try Again',
                            style: TextStyle(fontSize: 20, color: Colors.blue)))
                  ],
                ),
              ),
            ),
          );
        }
        else  {
          return Scaffold(
            body: Container(
              height: height,
                    width: width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.yellow, Colors.lightBlueAccent])),
                            child:   Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off,size: 200,),
                  SizedBox(height: 20,),
                  Text('Please check your internet connection and try again',style: TextStyle(fontSize: 17),),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: ()async{
                    
                    AppCubit.get(context).checkInternet();
                   if(AppCubit.get(context).connectionResult!=false){
                    
                       if(CacheHelper.getData(key: 'onBoarding') == null){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));
                     }
                     else if(CacheHelper.getData(key: 'onBoarding') != null){
                      
                       AppCubit.get(context).getHomeData().then((value) {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp(startWidget:Home())));
                       });
                       
                     }
                     
                     
                     
                   }else{
                   Fluttertoast.showToast(
                    msg: "No internet connection",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white,
                    fontSize: 16.0
    );
                   }
                  }, child: Text('Try again'))
                ],
              ),
            ),
      
            )
              );
        } 
        }

    );
  }
}
//ca-app-pub-1793256327308832/8370167505