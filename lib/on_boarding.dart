import 'package:flutter/material.dart';
import 'package:my_social_test/home.dart';
import 'package:my_social_test/local/cache_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var citydController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  print(citydController);
                  await CacheHelper.putData(
                          key: 'city', value: citydController.text)
                      .then((value) {
                    closeOnBoarding();
                  }).catchError((error) {
                    print(error.toString());
                  });
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                ))
          ],
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Column(
              
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                      height: 150,
                      width: 150,
                      child: Image(
                        image: AssetImage('images/cloudy1.png'),
                        fit: BoxFit.cover,
                      )),
                ),
                 Text('Welcome',style: TextStyle(fontSize: 50,color: Colors.blueGrey),),
                Text('Please Inter Your City Name',style: TextStyle(fontSize: 25,color: Colors.grey[600]),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // IconButton(
                      //     color: Colors.amber,
                      //     iconSize: 40,
                      //     onPressed: () {},
                      //     icon: Icon(Icons.check)),
                      Expanded(
                        child: TextFormField(
                          controller: citydController,
                          decoration: InputDecoration(
                            hintText: ' Yout City Name',
                            filled: true,
                            fillColor: Colors.yellow[300],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.yellow)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.yellow
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.yellow)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )

        //  Image(image: AssetImage('images/shop1.png'),)

        );
  }

  void closeOnBoarding() {
    CacheHelper.putData(key: 'onBoarding', value: true).then((value) {
      if (value)
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
    });
  }
}
