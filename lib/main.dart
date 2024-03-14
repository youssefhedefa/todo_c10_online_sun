
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_online_sun/core/providers/auth_provider.dart';
import 'package:todo_c10_online_sun/core/utilits/app_colors.dart';
import 'package:todo_c10_online_sun/model/task.dart';
import 'package:todo_c10_online_sun/ui/auth/login/login.dart';
import 'package:todo_c10_online_sun/ui/auth/register/register.dart';
import 'package:todo_c10_online_sun/ui/edit_task/edit_task_screen.dart';
import 'package:todo_c10_online_sun/ui/home_screen.dart';
import 'package:todo_c10_online_sun/ui/splash/splash_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context)=>AuthUserProvider(),
      child: const MyApp()));
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
      initialRoute: SplashScreen.routeName,
      routes: {
        RegisterScreen.routeName:(context) => RegisterScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
        SplashScreen.routeName:(context)=>const SplashScreen(),
        EditTaskScreen.routeName:(context)=> EditTaskScreen(task: Task(title: '', date: null, description: '',),)
      },
    );
  }
}
