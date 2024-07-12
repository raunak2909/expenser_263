import 'package:expense/data/local/exp_database.dart';
import 'package:expense/ui/user_on_board/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domains/app_colors.dart';
//import 'package:path/path.dart';

class SignUpPage extends StatelessWidget {

ExpDatabase db=ExpDatabase.ExpDatabase_obj;

var tfControlerFname=TextEditingController();
var tfControlerLname=TextEditingController();
var tfControlerEmail=TextEditingController();
var tfControlerPhn=TextEditingController();
var tfControlerPass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLandScape= MediaQuery.of(context).orientation==Orientation.landscape;
    return Scaffold(
      //backgroundColor: Colors.white,
      //appBar: AppBar(title:Text(''),backgroundColor: Colors.white,),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppColors.gradiantFirstColor,
                    AppColors.gradiantSecondColor
                  ],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,1.0)
              )
          ),
          child: isLandScape == true ? Container() : isPotrait(context: context,db: db, fname: tfControlerFname, lname: tfControlerLname, email: tfControlerEmail, phn: tfControlerPhn, pass: tfControlerPass),)
    );
  }
}

isLandScape()
{

}

isPotrait({required BuildContext context, required ExpDatabase db, required var fname,required var lname,required var email,required var phn, required var pass})
{
  return Padding(
    padding: EdgeInsets.only(left: 10,right: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text('Sign Up',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
       SizedBox(height: 20,),
       Row(children: [
         Expanded(child: TextField(

           controller: fname,
           decoration: InputDecoration(
             labelText: 'First Name',
            // prefixIcon: Icon(Icons.remove_red_eye),
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

           ),
         )),
         SizedBox(width: 10,),
         Expanded(child: TextField(

           controller: lname,
           decoration: InputDecoration(
             labelText: 'Last Name',
             //prefixIcon: Icon(Icons.remove_red_eye),
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

           ),
         ))
       ],),
        SizedBox(height: 10,),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: email,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

          ),
        ),
        SizedBox(height: 10,),
        TextField(
          keyboardType: TextInputType.number,
          controller: phn,
          decoration: InputDecoration(
            labelText: 'Phone',
            prefixIcon: Icon(Icons.phone_android),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

          ),
        ),
        SizedBox(height: 10,),
        TextField(
          obscureText: true,
          controller: pass,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.remove_red_eye),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

          ),
        ),
        SizedBox(height: 25,),
        SizedBox(
          height: 50,
          // width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 25),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xd15050ff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () async{
               // print('name: ${fname.text}');
                bool inserted=await db.insertionSignUp(fname: fname.text, lname: lname.text, email: email.text, phn: phn.text, password: pass.text);
                if(inserted)
                  {
                    fname.clear();
                    lname.clear();
                    email.clear();
                    phn.clear();
                    pass.clear();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                    Navigator.pop(context);
                  }

                }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                               Text("SignUp",),
            ],
          )),
        ),
        SizedBox(height: 10,),
        Text("Already have an account",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
      ],
    ),
  );
}