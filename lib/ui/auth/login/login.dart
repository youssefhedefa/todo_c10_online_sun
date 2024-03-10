import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_online_sun/core/firestore_helper.dart';
import 'package:todo_c10_online_sun/core/providers/auth_provider.dart';
import 'package:todo_c10_online_sun/core/utilits/dialog_utils.dart';
import 'package:todo_c10_online_sun/core/utilits/firebase_error_codes.dart';
import 'package:todo_c10_online_sun/ui/auth/register/register.dart';
import 'package:todo_c10_online_sun/ui/home_screen.dart';

import '../../../core/utilits/my_validation.dart';
import '../../componant/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName ="login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController EmailController =TextEditingController();

  TextEditingController PasswordController =TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Container(

        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/back_ground_auth.png"),
              fit: BoxFit.fill,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  CustomTextFormField(

                    controller: EmailController,
                    validation: (text){
                      if(text==null||text.trim().isEmpty){
                        return "enter valid email";
                      }
                      if(!MyValidations.isValidEmail(text)){
                        return "enter valid email";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",

                    ),
                  ),
                  CustomTextFormField(
                    controller: PasswordController,
                    validation: (text){
                      if(text==null||text.trim().isEmpty){
                        return "enter valid password";
                      }
                      if(text.length<6){
                        return "enter valid password";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                      onPressed: () {
                        login();
                      }, child: Text("Sign in",style: TextStyle(fontSize: 24,color: Colors.white),)),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                  }, child: Text(
                    "Don't have Account",
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> login() async {
    if(formKey.currentState?.validate()==false){
      return;
    }
    try {
      AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
      DialogUtils.showLoadingDialog(context: context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailController.text.trim(),
          password: PasswordController.text
      );
      provider.authUser = credential.user;
      provider.databaseUser = await FirestoreHelper.getUser(credential.user!.uid);
      print("Full Name: ${provider.databaseUser?.fullName}");
      DialogUtils.hideDialog(context: context);
      DialogUtils.showMessageDialog(context: context,
          message: "User signed in successfully ${credential.user?.uid}",
          positiveTitle: "Ok",
          positiveClick: (){
            DialogUtils.hideDialog(context: context);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context: context);
      if (e.code ==FirebaseAuthErrorCodes.userNotFound ) {
        DialogUtils.showMessageDialog(context: context,
            message: "No user found for that email",
            positiveTitle: "Ok",
            positiveClick: (){
              DialogUtils.hideDialog(context: context);
            }
        );
      } else if (e.code == FirebaseAuthErrorCodes.wrongPass) {
        DialogUtils.showMessageDialog(context: context,
            message: "Wrong password provided for that user",
            positiveTitle: "Ok",
            positiveClick: (){
              DialogUtils.hideDialog(context: context);
            }
        );
      }
    }
  }
}
