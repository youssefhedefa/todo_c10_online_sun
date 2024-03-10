import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_online_sun/core/providers/auth_provider.dart';
import 'package:todo_c10_online_sun/ui/auth/login/login.dart';
import 'package:todo_c10_online_sun/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/Splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      SplashFinish();
    });
    return Scaffold(
      backgroundColor: Color(0xffDFECDB),
      body: Center(
        child: Image.asset(
          "assets/images/splash.png"
        ),
      ),
    );
  }

  void SplashFinish()async{
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
    if(provider.isFirebaseLoggedIn()){
      await provider.retrieveDatabaseUser();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }else{
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }

  }
}
