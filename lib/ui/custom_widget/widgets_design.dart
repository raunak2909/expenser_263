import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldsDesign extends StatelessWidget{

  String? labelText;
  bool? isObscure;
 // Icon? ic_prefix = null;
  TextFieldsDesign({this.isObscure, required this.labelText,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      obscureText: isObscure== null ? false :true,
      decoration: InputDecoration(
        labelText: labelText,
       // prefixIcon: icon == null ? null : Icon(this.ic_prefix!),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey)
        ),
      ),
    );
  }
}