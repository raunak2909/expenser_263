import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Expense", style: TextStyle(color: Colors.black,fontSize: 21,fontWeight: FontWeight.bold),),
         Image(image:AssetImage('asset/icon/search_icon.png'),width: 30,),
        ],
      ),
        SizedBox(
          height: 20,
        ),
        Row(children: [
          CircleAvatar(child: Icon(Icons.account_circle),radius: 25,),

        ],)
    ],);
  }
}
