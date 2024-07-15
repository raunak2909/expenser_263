import 'package:expense/data/local/exp_database.dart';
import 'package:expense/domains/app_colors.dart';
import 'package:expense/ui/user_on_board/login_provider/login_provider.dart';
import 'package:expense/ui/user_on_board/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../homes/dashboard.dart';

class LoginPage extends StatelessWidget {
  ExpDatabase db=ExpDatabase.ExpDatabase_obj;
  var tfControllerEmail=TextEditingController();
  var tfControllerPass=TextEditingController();

  bool isSuccessfullyLoggedIn=false;

  @override
  Widget build(BuildContext context) {
  bool isLandscapes = MediaQuery.of(context).orientation==Orientation.landscape;
    return SafeArea(
      child: Scaffold(
       // backgroundColor: Colors.white,
       // appBar: AppBar(

         // backgroundColor: Colors.white,
          //title: Center(child: Text("",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),),
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
         // margin: EdgeInsets.only(left: 10,right: 10),
          child: isLandscapes == true ? isLandscape() : isPotrait(context,db,tfControllerEmail,tfControllerPass),),

      ),
    );
  }
}



isLandscape()
{
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(
        flex: 7,
        child: Container(
          child: Image(image: AssetImage('asset/images/expense_login.png'),fit: BoxFit.fill,),
        ),
    ),
    SizedBox(width: 20,),
    Expanded(
        flex: 3,
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.
          children: [
            Text("LogIn",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

              ),
            ),
            SizedBox(height: 20,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.remove_red_eye),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

              ),
            ),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(onTap: (){
                print("forgot Password");
              },
                  child: Text("Forgot password",style: TextStyle(color: Color(0xd15050ff)),)),),
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
                  onPressed: (){}, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log In",),
                ],
              )),
            ),
            SizedBox(height: 20,),
            Text.rich(TextSpan(
                text: 'Don\'t have an account ',
                style: TextStyle(fontSize:10,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: 'Create an account',
                      recognizer: TapGestureRecognizer()..onTap = (){
                        //  print("hello");
                      },
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Color(0xd15050ff))),
                ]),),

          ],
        ))
  ],);
}

isPotrait(BuildContext context, ExpDatabase db, var tfEmail, var tfPass) {
  return
    Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("LogIn",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      SizedBox(height: 20,),
      TextField(
        controller: tfEmail,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

          ),
      ),
        SizedBox(height: 20,),
        TextField(
          controller: tfPass,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.remove_red_eye),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey)),

          ),
        ),
        SizedBox(height: 15,),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(onTap: (){
            print("forgot Password");
          },
              child: Text("Forgot password",style: TextStyle(color: Color(0xd15050ff)),)),),
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
                        bool check =await db.loginAuthentication(emailId: tfEmail.text, pass: tfPass.text);
                      //  List<Map<String,dynamic>> data=await context.read<LoginProvider>().providerLoginAuthentication(email: tfEmail.text, pass: tfPass.text);
                        if(check){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dashboard()));
                        }
                        else
                          {
                           print("invalid");
                          }
                      }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log In",),
                ],
              )),
        ),
        SizedBox(height: 20,),
        Text.rich(TextSpan(
           text: 'Don\'t have an account ',
            style: TextStyle(fontSize:10,fontWeight: FontWeight.bold,),
            children: [
              TextSpan(text: 'Create an account',
                  recognizer: TapGestureRecognizer()..onTap = ()
                  {
                    //  print("hello");
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
                  },
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Color(0xd15050ff))),
            ]),),

        ],
        ),
    );
}

// Bottomsheet code with middle Icon

/*
 showModalBottomSheet(
                    barrierColor: Colors.grey,
                   // isDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Stack(
                          clipBehavior: Clip.none,
                          children: [
                        Container(
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                          ),
                          height: 700,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Center(
                              child: Column(
                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: 20,),
                                 Text('Sign Up',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: -30,
                            right: MediaQuery.of(context).size.width/2.25,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: Icon(Icons.account_circle,size: 55,),
                            )
                        ),
                        Positioned(
                           // top: 0,
                            right: 1,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100
                              ),
                              child: InkWell(child: Icon(Icons.close,),onTap: (){
                                Navigator.pop(context);
                              },),
                            )
                        ),

                      ]);
                    },
                  );
 */