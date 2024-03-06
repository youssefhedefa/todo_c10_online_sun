import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_online_sun/core/firestore_helper.dart';
import 'package:todo_c10_online_sun/core/utilits/dialog_utils.dart';
import 'package:todo_c10_online_sun/core/utilits/firebase_error_codes.dart';
import 'package:todo_c10_online_sun/ui/auth/login/login.dart';
import 'package:todo_c10_online_sun/ui/home_screen.dart';
import 'package:todo_c10_online_sun/model/user.dart' as MyUser;
import '../../../core/utilits/my_validation.dart';
import '../../componant/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName ="register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController =TextEditingController();
  TextEditingController ageController =TextEditingController();

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
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    validation: (text){
                      if(text==null||text.trim().isEmpty){
                        return "enter valid age";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "age",
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

  Future<void> register() async {
    if(formKey.currentState?.validate()==false){
      return;
    }
    try {
      DialogUtils.showLoadingDialog(context: context);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text.trim(),
        password: PasswordController.text,
      );
      await FirestoreHelper.AddNewUser(MyUser.User(
        id: credential.user!.uid,
        age: int.parse(ageController.text),
        email: EmailController.text,
        fullName: fullNameController.text
      ));
      DialogUtils.hideDialog(context: context);
      DialogUtils.showMessageDialog(
          context: context,
          message: "User registered successfully ${credential.user?.uid}",
          positiveTitle: "Ok",
          positiveClick: (){
            DialogUtils.hideDialog(context: context);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context: context);
      if (e.code == FirebaseAuthErrorCodes.weakPass) {
        DialogUtils.showMessageDialog(
            context: context,
            message: 'The password provided is too weak.',
            positiveTitle: "Ok",
            positiveClick: (){
              DialogUtils.hideDialog(context: context);
            }
        );
      } else if (e.code == FirebaseAuthErrorCodes.emailAlreadyInUse) {
        DialogUtils.showMessageDialog(
            context: context,
            message: 'The account already exists for that email.',
            positiveTitle: "Ok",
            positiveClick: (){
              DialogUtils.hideDialog(context: context);
            }
        );
      }
    } catch (e) {
      DialogUtils.hideDialog(context: context);
      DialogUtils.showMessageDialog(
          context: context,
          message: e.toString(),
          positiveTitle: "Ok",
          positiveClick: (){
            DialogUtils.hideDialog(context: context);
          }
      );
      print(e);
    }
  }
}
