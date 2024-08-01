import 'dart:async';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homes/dashboard.dart';
import '../user_on_board/login_page.dart';
class SplashPage extends StatefulWidget {

  static const String loggedInRecordCheck="IsLoggedIn";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
String? alreadyLoggedIn = "home";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 1), () async{
    var pref =  await SharedPreferences.getInstance();
    //alreadyLoggedIn = pref.getString(SplashPage.loggedInRecordCheck);
    toJump();
    });

  }

  toJump()
  {
    if(alreadyLoggedIn == null || alreadyLoggedIn == '')
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
      }
    else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Dashboard()));
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: Image(image: AssetImage("asset/splash_img/non_tracking_expenses.png"),),),
        )
      ),
    );
  }
}
