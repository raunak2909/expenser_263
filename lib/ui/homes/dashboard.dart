import 'package:expense/ui/homes/bottom_bar_widget/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../expense_managment/add_expenses.dart';

class Dashboard extends StatefulWidget {

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Color bottomSelectItemClr=Color.fromARGB(255, 231, 138, 188);

  int currentIndex=0;
  List<Widget> bottomNavigatorPage=[
    Home(),
    Home(),
    Home(),
    Home(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeIndexvalue(index: 0);
  }
  changeIndexvalue({required int index})
  {
    currentIndex=index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15),
        child: bottomNavigatorPage[currentIndex],
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(top: BorderSide(color: Colors.grey.shade300))
        ),
        padding: EdgeInsets.only(top: 10.0,bottom: 10,left: 20,right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(child: currentIndex ==0 ? Icon(Icons.home, color: bottomSelectItemClr,size: 35,) : Icon(Icons.home, color: Colors.grey,),
            onTap: ()
              {
                changeIndexvalue(index: 0);
              },),
            InkWell(child: currentIndex ==1 ? Icon(Icons.bar_chart, color: bottomSelectItemClr,size: 35,) : Icon(Icons.bar_chart, color: Colors.grey,),
            onTap: (){
              changeIndexvalue(index: 1);
            }),
            Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 138, 188),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.add,size: 40,color: Colors.white,)),
            InkWell(child: currentIndex ==2 ? Icon(Icons.notifications, color: bottomSelectItemClr,size: 35,) : Icon(Icons.notifications, color: Colors.grey,),
                onTap: (){
                  changeIndexvalue(index: 2);
                }),
            InkWell(child: currentIndex ==3 ? Icon(Icons.account_circle, color: bottomSelectItemClr,size: 35,) : Icon(Icons.account_circle, color: Colors.grey,),
                onTap: (){
                  changeIndexvalue(index: 3);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>AddExpenses()));
                }),

            //REPLACE WITH ICON
          ],
        ),
      ),


     /* NavigationBar(
        destinations: [
        NavigationDestination(icon: Image.asset("asset/icon/home_bottom_navigator.png",width: 30,), label: ''),
        NavigationDestination(icon: Icon(Icons.bar_chart,), label: '', ),
        Container(
            //margin: EdgeInsets.only(top: 15,right: 10,left: 10,bottom: 30),
            color: Color.fromARGB(255, 231, 138, 188),
            child: NavigationDestination(icon: Icon(Icons.add,size: 40,color: Colors.white,), label: '' )),
        NavigationDestination(icon: Icon(Icons.notifications), label: '', ),
        NavigationDestination(icon: Icon(Icons.account_circle), label: ''),
      ],

      ),*/
    );
  }
}
