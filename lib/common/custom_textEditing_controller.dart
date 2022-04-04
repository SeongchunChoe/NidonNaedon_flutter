import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextEditingController extends TextEditingController{

  CustomTextEditingController(String? text) : super(text: text){
    super.selection = TextSelection.fromPosition(TextPosition(offset: text?.length as int));
  }
}