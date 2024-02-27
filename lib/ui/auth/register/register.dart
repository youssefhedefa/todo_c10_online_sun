import 'package:flutter/material.dart';
import 'package:todo_c10_online_sun/ui/auth/login/login.dart';
import 'package:todo_c10_online_sun/ui/home_screen.dart';

import '../../../core/utilits/my_validation.dart';
import '../../componant/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName ="register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController =TextEditingController();

  TextEditingController EmailController =TextEditingController();

  TextEditingController PasswordController =TextEditingController();

  TextEditingController PasswordConfirmationController =TextEditingController();

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
                    controller: fullNameController,
                    validation: (text){
                      if(text==null||text.trim().isEmpty){
                        return "enter valid name";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                    ),
                  ),
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
                  CustomTextFormField(
                    controller: PasswordConfirmationController,
                    validation: (text){
                      if(text==null||text.trim().isEmpty){
                        return "enter valid email";
                      }
                      if(PasswordController.text != text){
                        return "password dos't match";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                       register();
                  }, child: Text("Create Account",style: TextStyle(fontSize: 24,color: Colors.white),)),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  }, child: Text(
                    "Already have Account",
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  void register() {
    if(formKey.currentState?.validate()==false){
      return;
    }
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
