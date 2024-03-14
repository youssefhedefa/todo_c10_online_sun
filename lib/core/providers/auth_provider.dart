
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_online_sun/core/firestore_helper.dart';
import 'package:todo_c10_online_sun/model/user.dart' as MyUser;

class AuthUserProvider extends ChangeNotifier{
  User? authUser;
  MyUser.User? databaseUser;


  bool isFirebaseLoggedIn(){
    if(FirebaseAuth.instance.currentUser != null){
      authUser = FirebaseAuth.instance.currentUser;
      return true;
    }else{
      return false;
    }
  }

  Future<void> retrieveDatabaseUser()async{
    databaseUser = await FirestoreHelper.getUser(authUser!.uid);
  }
}