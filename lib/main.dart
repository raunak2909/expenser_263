import 'package:expense/data/local/exp_database.dart';
import 'package:expense/ui/user_on_board/login_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/homes/dashboard.dart';
import 'ui/splash/splash_page.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>LoginProvider(),
    child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'poppins',
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
