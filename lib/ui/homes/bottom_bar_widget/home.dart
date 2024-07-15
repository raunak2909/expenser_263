import 'package:expense/data/local/exp_database.dart';
import 'package:expense/ui/user_on_board/login_provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  List<Map<String,dynamic>> loginRecordDetails=[];
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
          SizedBox(width: 10,),
        ],),
        SizedBox(
          height: 20,
        ),
        Card(
          child: Container(
            height: 150,
            width: double.infinity,

            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Text("hello"),
            ],),
          ),
        )

    ],);
  }
}

/*
 Consumer<LoginProvider>(builder: (context,providerData,child)
          {
            loginRecordDetails=providerData.fetchUserId();
            return Text('${loginRecordDetails[0][ExpDatabase.COLUMN_NAME_LOGIN_TB_EMAIL]}');
          })
 */