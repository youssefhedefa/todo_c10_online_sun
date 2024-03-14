import 'package:flutter/material.dart';

class DialogUtils{

  static void showLoadingDialog({required BuildContext context}){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width:20),
          Text("Loading...")
        ],
      ),
    ));
  }
  static void hideDialog({required BuildContext context}){
    Navigator.pop(context);
  }

  static void showMessageDialog({required BuildContext context,
    required String message,
    String? positiveTitle,
    void Function()? positiveClick,
    String? negativeTitle,
    void Function()? negativeClick
  }){
    showDialog(context: context,
        builder: (context)=>AlertDialog(
      content: Text(message),
      actions: [
        if(positiveTitle!=null)
          TextButton(
              onPressed: (){
                positiveClick!();
              },
              child: Text(positiveTitle??"")
          ),
        if(negativeTitle!=null)
          TextButton(
            onPressed: (){
              negativeClick!();
            },
            child: Text(negativeTitle??"")
        ),
      ],
    ));
  }
}