
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  InputDecoration? decoration;
  TextEditingController controller;
  int maxLines;
  int minLines;
  TextInputType? keyboardType;
  String? Function(String?)? validation;

  CustomTextFormField(
      {this.decoration,this.keyboardType, required this.controller,  this.validation, this.maxLines=1,this.minLines=1,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:keyboardType ,
      maxLines: maxLines,
      minLines: minLines,
      decoration: decoration,
      controller: controller,
      validator: validation,
    );
  }
}
