import 'package:expense/data/local/exp_database.dart';
import 'package:expense/data/models/cat_model.dart';
import 'package:expense/data/models/expense_model.dart';
import 'package:expense/domains/app_constants.dart';
import 'package:expense/domains/app_prefs.dart';
import 'package:expense/ui/custom_widget/widgets_design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatelessWidget {

  var tfControllerSpent=TextEditingController();
  ExpDatabase db=ExpDatabase.ExpDatabase_obj;
  bool categotyOptionVisible=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Expenses"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          // padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Spent",
                style: TextStyle(fontSize: 21, color: Colors.grey.shade400),
              ),
              SizedBox(
                height: 21,
              ),

              StatefulBuilder(builder: (_,ss){
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 150, right: 150),
                      child: TextField(
                        controller: tfControllerSpent,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            size: 50,
                          ),
                        ),
                        onChanged: (value){
                          checkSpentIsEmpty();
                          ss((){});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    categotyOptionVisible==true ? Text("Select Expense Categoty",style: TextStyle(fontSize: 21, color: Colors.grey.shade400)) : Container(),
                    SizedBox(
                      height: 21,
                    ),
                    categotyOptionVisible==true ?InkWell(
                      child: Icon(Icons.category, size: 40,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                         // barrierColor: Colors.grey,
                          // isDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                height: 700,
                                child:  Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: Text(
                                            'Category',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 25,),
                                        GridView.builder(
                                            itemCount: AppConstants.mCategories.length,
                                            shrinkWrap: true,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                               /* crossAxisSpacing: 10,
                                                mainAxisSpacing: 10*/
                                            ),
                                            itemBuilder: (_,index){
                                              return Column(
                                                children: [
                                                  //Image.asset(AppConstants.mCategories[index][])
                                                  Icon(Icons.account_balance)
                                                ],
                                              );
                                            })
                                      ],
                                    ),

                              );
                          },
                        );
                      },
                    ) : Container(),
                    SizedBox(
                      height: 21,
                    ),
                    categotyOptionVisible==true ? ElevatedButton(onPressed: (){

                      var prefs=AppPrefs();
                      int uId=prefs.getUserId();

                      db.addUserExpense(ExpenseModel(userId: uId, catId: 1, expAmt: int.parse(tfControllerSpent.text), expBal: 1000, expTitle: 'Shopping', expDesc: 'Shopping', expType: "Coffee", expCreatedAt: '15-Jul-2024'));
                      categotyOptionVisible=false;
                      tfControllerSpent.clear();
                    }, child: Text("Save")) : Container(),
                  ],
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
  checkSpentIsEmpty()
  {
    if(tfControllerSpent.text.toString().isNotEmpty)
      {
        categotyOptionVisible=true;
      }
    else{
      categotyOptionVisible=false;
    }
  }
}
