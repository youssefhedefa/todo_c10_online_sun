import 'dart:math';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  InputDecoration? decoration;
  TextEditingController controller;
  int maxLines;
  int minLines;
  String? Function(String?)? validation;

  CustomTextFormField(
      {this.decoration, required this.controller, required this.validation, this.maxLines=1,this.minLines=1,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      decoration: decoration,
      controller: controller,
      validator: validation,
    );
  }
}
