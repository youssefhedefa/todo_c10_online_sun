import 'package:flutter/material.dart';
import 'package:todo_c10_online_sun/core/utilits/app_colors.dart';
import 'package:todo_c10_online_sun/ui/auth/login/login.dart';
import 'package:todo_c10_online_sun/ui/auth/register/register.dart';
import 'package:todo_c10_online_sun/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: false,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        RegisterScreen.routeName:(context) => RegisterScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
      },
    );
  }
}
