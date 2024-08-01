import 'package:expense/data/local/exp_database.dart';
import 'package:expense/firebase_options.dart';
import 'package:expense/ui/bloc/expense_bloc.dart';
import 'package:expense/ui/user_on_board/login_provider/login_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ui/homes/dashboard.dart';
import 'ui/splash/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (context)=>LoginProvider(),),
      BlocProvider(create: (context) => ExpenseBloc(db: ExpDatabase.ExpDatabase_obj),)
    ],
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
